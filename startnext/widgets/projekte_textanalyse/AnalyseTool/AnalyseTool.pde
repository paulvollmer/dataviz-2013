/**
 * Startnext Project Textanalyse.
 */

boolean DEBUGGING = false;
StartnextProjectJSON project = new StartnextProjectJSON(DEBUGGING);
TextAnalyse analyse = new TextAnalyse();

void setup() {
	// Loading file from data directory outside of this sketch.
	// ../startnext/widgets/projekte_textanalyse/data/
  String FILEPATH_BASE = "../data/project_id_";
  String SUFFIX = ".json";
  project.load(FILEPATH_BASE+"772"+SUFFIX);
  println(analyse.totalWords(project.teaser));

  // Write the JSON file.
  JSONObject json = new JSONObject();
  json.setInt("id", 0);
  json.setInt("foo", 42);
  saveJSONObject(json, "test.json");

  // Quit the application.
  exit();
}
