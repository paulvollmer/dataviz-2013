/**
 * Startnext Project Textanalyse.
 */

StartnextProjectJSON project = new StartnextProjectJSON();

void setup() {
  String FILENAME_BASE = "project_id_";
  String SUFFIX = ".json";
  project.loadFiles(FILENAME_BASE, SUFFIX, 0, 100);
  println(project.wc.dictionary);
  exit();
}

