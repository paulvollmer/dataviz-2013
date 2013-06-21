/**
 * Startnext Project JSON
 */
class StartnextProjectJSON
{

  WordCounter wc;
  //JSONObject json;

  String title;
  String teaser;
  JSONArray answers;
  JSONArray keywords;
  JSONArray categories;

  // Some JSON keys we use
  private String JSON_KEY_STATUS     = "status";
  private String JSON_KEY_TITLE      = "title";
  private String JSON_KEY_TEASER     = "teaser";
  private String JSON_KEY_ANSWERS    = "answers";
  private String JSON_KEY_KEYWORDS   = "keywords";
  private String JSON_KEY_CATEGORIES = "categories";


  /**
   * Constructor
   */
  StartnextProjectJSON() {
    wc = new WordCounter();
  }

  /**
   * Load the JSON file.
   */



  void loadFiles(String prefix, String suffix, int offset, int limit)
  {
    for (int i=offset; i<limit; i++)
    {
      load(prefix + i + suffix);
    }
    wc.dictionary.sortValues();
  }



  void load(String filepath)
  {
    println("StartnextProjectJSON load: " + filepath);
    
    try {

      // Load a Startnext API project JSON file.
      JSONObject json;
      json = loadJSONObject(filepath);

      if ( json != null) {
        // Check the status of the JSON file. If zero, requested JSON file is valid. 
        if (getStatus(json) == 0) {
          println("StartnextProjectJSON StartnextProjectJSON API Status OK");

          // The data Object is an array. Create a new JSONArray instance to...
          JSONArray data = json.getJSONArray("data");
          // ...read the first object of the data array. 
          JSONObject dataItems = data.getJSONObject(0);

          // Get the data we need.
          title  = getString(dataItems, JSON_KEY_TITLE);
          teaser = getString(dataItems, JSON_KEY_TEASER);
          answers    = getJSONArray(dataItems, JSON_KEY_ANSWERS);
          keywords   = getJSONArray(dataItems, JSON_KEY_KEYWORDS);
          categories = getJSONArray(dataItems, JSON_KEY_CATEGORIES);


          analyseJSONArray(answers);
        }
        // Something went wrong with this JSON... else {
        println("StartnextProjectJSON API Status not correct. Code: " + getStatus(json));
      }
    } 
    catch(Exception e) {
      println(e);
    }
  }


  void analyseJSONArray(JSONArray json)
  {
    for (int i=0; i<json.size(); i++)
    {
      wc.countWords(json.getString(i));
    }
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
    int status;
    if (json.hasKey(JSON_KEY_STATUS)) {
      status = json.getInt(JSON_KEY_STATUS);
    } else {
      status = -1;
    }
    return status;
  }

  /**
   * Read a JSON String object and return the value.
   */
  String getString(JSONObject data, String key) {
    String s = data.getString(key);
    //println("StartnextProjectJSON "+key+" = "+s);
    return s;
  }

  /**
   * Read a JSON Array and return it.
   */
  JSONArray getJSONArray(JSONObject data, String key) {
    JSONArray a = data.getJSONArray(key);
    //println("StartnextProjectJSON "+key+" = "+a);
    return a;
  }
}

