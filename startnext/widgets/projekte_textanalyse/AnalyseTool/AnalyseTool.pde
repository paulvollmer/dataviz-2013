/**
 * Startnext Project Textanalyse.
 */

boolean DEBUGGING = false;
StartnextProjectJSON project = new StartnextProjectJSON();

void setup() {
  String FILENAME_BASE = "project_id_";
  String SUFFIX = ".json";
  project.loadFiles(FILENAME_BASE, SUFFIX, 0, 100);
  println(project.wc.dictionary);

  // Write the JSON file.
  JSONObject json = new JSONObject();
  json.setInt("WC", project.wc.dictionary);
  saveJSONObject(json, "test.json");

  exit();
}

