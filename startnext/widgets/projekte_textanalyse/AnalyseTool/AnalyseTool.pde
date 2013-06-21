/**
 * Startnext Project Textanalyse.
 */

boolean DEBUGGING = false;
StartnextProjectJSON project = new StartnextProjectJSON();

void setup() {
  String FILENAME_BASE = "project_id_";
  String SUFFIX = ".json";
  project.loadFiles(FILENAME_BASE, SUFFIX, 0, 2000);
  println(project.wc.dictionary);

  // Write the JSON file.
  JSONObject json = new JSONObject();
  
  JSONArray values = new JSONArray();
  int i = 0;
  for (String k : project.wc.dictionary.keys()) {
    println(k+", "+project.wc.dictionary.get(k));
    JSONObject word = new JSONObject();
    word.setString("name", k);
    word.setInt("count", project.wc.dictionary.get(k));
    word.setString("type", "foo");
    values.setJSONObject(i, word);
    i++;
  }
  json.setJSONArray("words", values);
  saveJSONObject(json, "test.json");
  exit();
}
