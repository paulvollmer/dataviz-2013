/**
 * Startnext Project JSON
 */
class StartnextProjectJSON
{

  WordCounter wc, wcFunded, wcNotFunded;
  WordPerMonthCounter wcPerMonth;
  TextAnalyser ta;
  ArrayList<ProjectInfo> infos;
  TagCounter tagCounter;

  // Some JSON keys we use
  private String JSON_KEY_TITLE                  = "title";
  private String JSON_KEY_STATUS                 = "status";
  private String JSON_KEY_FUNDING_THRESHOLD      = "funding_threshold";
  private String JSON_KEY_END_DATE               = "end_date";
  private String JSON_KEY_TEASER                 = "teaser";
  private String JSON_KEY_ANSWERS                = "answers";
  private String JSON_KEY_FUNDING_STATUS         = "funding_status";
  private String JSON_KEY_KEYWORDS               = "keywords";
  private String JSON_KEY_CATEGORIES             = "categories";

  private long timestampNow;

  /**
   * Constructor
   */
  StartnextProjectJSON()
  {
    wc = new WordCounter();
    wcFunded = new WordCounter();
    wcNotFunded = new WordCounter();
    ta = new TextAnalyser();
    tagCounter = new TagCounter();
    timestampNow = System.currentTimeMillis();
    infos = new ArrayList<ProjectInfo>();
    wcPerMonth = new WordPerMonthCounter();
  }

  /*
 * ============================================================================
   * JSON FILE LOAD FUNCTIONS
   * ============================================================================
   */

  /**
   * Load the JSON files.
   */
  void loadFiles(String prefix, String suffix, int offset, int limit)
  {
    for (int i=offset; i<limit; i++)
    {
      load(prefix + i + suffix);
    }

    wc.dictionary.sortValuesReverse();
    wcFunded.dictionary.sortValuesReverse();
    wcNotFunded.dictionary.sortValuesReverse();
  }


  /**
   * Load a Startnext API project JSON file
   */
  void load(String filepath) {
    Dbg.println("StartnextProjectJSON load: " + filepath);
    JSONObject json = null;
    try {
      json = loadJSONObject(filepath);
    } 
    catch(Exception e) {
      println(e);
    }

    if (json != null) {
      // Check the status of the JSON file. If zero, requested JSON file is valid.
      int status = getStatus(json);  
      switch(status) {
      case 0:
        Dbg.println("StartnextProjectJSON StartnextProjectJSON API Status OK");
        analyseJson(json);
        break;
      default:
        // Something went wrong with this JSON... else {
        System.err.println("StartnextProjectJSON API Status not correct. Code: " + status);
      }
    } else {
      System.err.println("loadJson(): json == null");
    }
  }

  /*
 * ============================================================================
   * JSON ANALYSE FUNCTIONS
   * ============================================================================
   */

  void analyseJson(JSONObject json) {
    // The data Object is an array. Create a new JSONArray instance to...
    JSONArray data = json.getJSONArray("data");
    // ...read the first object of the data array. 
    JSONObject dataItems = data.getJSONObject(0);

    // Get the data we need.
    String title  = getString(dataItems, JSON_KEY_TITLE);
    String teaser = getString(dataItems, JSON_KEY_TEASER);
    JSONArray answers    = getJSONArray(dataItems, JSON_KEY_ANSWERS);
    String[] keywords   = getJSONArray(dataItems, JSON_KEY_KEYWORDS).getStringArray();
    JSONArray categories = getJSONArray(dataItems, JSON_KEY_CATEGORIES);
    int funding_threshold = -1;
    if (dataItems.hasKey(JSON_KEY_FUNDING_THRESHOLD)) {
      funding_threshold = getInt(dataItems, JSON_KEY_FUNDING_THRESHOLD);
    }
    int funding_status = 0;
    if (dataItems.hasKey(JSON_KEY_FUNDING_STATUS)) {
      funding_status = getInt(dataItems, JSON_KEY_FUNDING_STATUS);
    }
    boolean isFunded = funding_status >= funding_threshold ? true : false;

    ProjectInfo info = new ProjectInfo();

    // Answers
    String answersAll = mergeStringsFromJsonArray(answers, "");
    
    //merge the sKeywords and add them to their corresponding month
    //wcPerMonth.countWordsInMonth(mergeStringsFromJsonArray(keywords, " "), getLong(dataItems, JSON_KEY_END_DATE));

    wc.countWords(answersAll);
    info.answersTextInfo = ta.analyse(answersAll);
    // Teaser
    info.teaserTextInfo = ta.analyse(teaser);
    // Tags
    info.nTags = keywords.length;
    // funded / not funded
    info.successful = isFunded;
    // only add finished items to the list
    if (!isStillActive(dataItems)) {
      infos.add(info);
      if (isFunded) {
        wcFunded.countWords(answersAll);
      }
      else {
        wcNotFunded.countWords(answersAll);
      }
    }
    for(String s: keywords){
      tagCounter.addTag(s);
    }
    Dbg.println(infos.size() + "");
  }

  /*
 * ============================================================================
   * PRINT HELPER FUNCTIONS
   * ============================================================================
   */

  void printMostFrequentWords(int wordsToDisplay) {
    PrintUtil.printHeader("Most frequent words (top " + wordsToDisplay + ")");
    IntDictUtil.printFirstNElements(wc.dictionary, wordsToDisplay);
  }

  void printMostFrequentWordsFundedOnly(int wordsToDisplay) {
    PrintUtil.printHeader("Most frequent words (top " + wordsToDisplay + ", funded only)");
    IntDictUtil.printFirstNElements(wcFunded.dictionary, wordsToDisplay);
  }

  void printMostFrequentWordsNotFundedOnly(int wordsToDisplay) {
    PrintUtil.printHeader("Most frequent words (top " + wordsToDisplay + ", not funded only)");
    IntDictUtil.printFirstNElements(wcNotFunded.dictionary, wordsToDisplay);
  }

  /*
 * ============================================================================
   * JSON ANALYSE HELPER FUNCTIONS
   * ============================================================================
   */

  public boolean isStillActive(JSONObject dataItems) {
    long timestampEndDate = getLong(dataItems, JSON_KEY_END_DATE);
    return timestampEndDate > timestampNow;
  }


  /**
   * Get the Startnext API status code if the JSON key is determined.
   *
   * +------+-------------------------------------------------------------------------------------+
   * | Code | Bedeutung                                                                           |
   * +------+-------------------------------------------------------------------------------------+
   * | 0    | Rückgabe gemäß Erwartungen.                                                         |
   * | 400  | Ein oder mehrere Parameter fehlen oder sind ungültig.                               |
   * | 401  | Der Benutzer konnte nicht authentifiziert werden bzw. ist der AccessToken ungültig. |
   * | 404  | Die angeforderte Ressource wurde nicht gefunden.                                    |
   * | 500  | Ein interner Fehler ist aufgetreten.                                                |
   * +------+-------------------------------------------------------------------------------------+
   * Documentation copied from http://doc.startnext.de
   */

  int getStatus(JSONObject json) {
    int status = -1;
    if (json.hasKey(JSON_KEY_STATUS)) {
      status = json.getInt(JSON_KEY_STATUS);
    } 
    return status;
  }

  /*
 * ============================================================================
   * HELPER FUNCTIONS - JSON
   * ============================================================================
   */

  /**
   * Read a JSON String object and return the value.
   */
  String getString(JSONObject data, String key) {
    String s = data.getString(key);
    //println("StartnextProjectJSON "+key+" = "+s);
    return s;
  }

  /**
   * Read a JSON String object and return the value.
   */
  int getInt(JSONObject data, String key) {
    int i = data.getInt(key);
    return i;
  }

  /**
   * Read a JSON String object and return the value.
   */
  long getLong(JSONObject data, String key) {
    long l = data.getLong(key);
    return l;
  }

  /**
   * Read a JSON Array and return it.
   */
  JSONArray getJSONArray(JSONObject data, String key) {
    JSONArray a = data.getJSONArray(key);
    //println("StartnextProjectJSON "+key+" = "+a);
    return a;
  }

  /**
   * Sums all Strings in the JSONArray up as a new String 
   */
  public String mergeStringsFromJsonArray(JSONArray jArr, String delimiter) {
    String ret = "";
    for (int i=0; i<jArr.size(); i++) {
      ret += jArr.getString(i) + delimiter;
    }
    return ret;
  }
}

