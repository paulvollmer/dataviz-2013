/**
 * Startnext Project Textanalyse.
 */

StartnextProjectJSON project = new StartnextProjectJSON();

void setup() {
  String FILENAME_BASE = "project_id_";
  String SUFFIX = ".json";
  project.load(FILENAME_BASE+"772"+SUFFIX);
  exit();
}
