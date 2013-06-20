/**
 * Startnext Project JSON
 */
class StartnextProjectJSON {
  
  // Data of this project.
  public int status;
  public String title;
  public String teaser;
  public JSONArray answers;
  public JSONArray keywords;
  public JSONArray categories;

  // Some private variables...
  private boolean debugging = false;

  // Some JSON keys we need to get the data.
  private String JSON_KEY_STATUS     = "status";
  private String JSON_KEY_TITLE      = "title";
  private String JSON_KEY_TEASER     = "teaser";
  private String JSON_KEY_ANSWERS    = "answers";
  private String JSON_KEY_KEYWORDS   = "keywords";
  private String JSON_KEY_CATEGORIES = "categories";
  
  
  /**
   * Constructor
   */
  StartnextProjectJSON(boolean debug) {
    debugging = debug;
    if(debugging){
      log("Run Debug Mode.");
    }
  }
  
  /**
   * Load the JSON file.
   */
  public void load(String filepath) {
    log("load: "+filepath);
    
    // Create a temporary JSONObject instance.
    JSONObject json;

    // Load a Startnext API project JSON file and read parameter we need.
    json = loadJSONObject(filepath);
    updateVariables(json);
  }

  /**
   * The main get function.
   * Here we read all our JSON parameter we need.
   */
  private void updateVariables(JSONObject json) {
    updateStatus(json);

    // Check the status of the JSON file. If zero, requested JSON file is valid. 
    if(status == 0) {
      log("API Status OK");
      
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
    }
    // Something went wrong with this JSON...
    else {
      log("API Status not correct. Code: "+status);
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
  private void updateStatus(JSONObject json) {
    if(json.hasKey(JSON_KEY_STATUS)) {
      status = json.getInt(JSON_KEY_STATUS);
    } else {
      status = -1;
    }
  }

  /**
   * Read a JSON String object and return the value.
   */
  private String getString(JSONObject json, String key) {
    String s = json.getString(key);
    log(key+" = "+s);
    return s;
  }

  /**
   * Read a JSON Array and return it.
   */
  private JSONArray getJSONArray(JSONObject json, String key) {
    JSONArray a = json.getJSONArray(key);
    log(key+" = "+a);
    return a;
  }

  /**
   * Private logging helper
   */
  private void log(String s) {
    if(debugging){
      println("StartnextProjectJSON -> "+s);
    }
  }
  
}
