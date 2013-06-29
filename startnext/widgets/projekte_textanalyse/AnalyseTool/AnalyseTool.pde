import java.util.Map;
import java.util.Iterator;

/**
 * Startnext Project Textanalyse.
 */

boolean DEBUGGING = true;
String FILENAME_BASE = "project_id_";
String SUFFIX = ".json";

//String testText = "Die Nashörner (Rhinocerotidae) oder auch Rhinozerosse bilden eine Familie der Unpaarhufer (Perissodactyla) mit heute noch fünf lebenden Arten. Sie sind charakterisiert durch einen kräftigen Körper und kurze Gliedmaßen mit drei Zehen sowie einen großen Kopf, der bei allen heute lebenden Vertretern eine markante Bildung bestehend aus einem oder zwei – für die Familie namengebenden – Hörnern trägt. Die Familie stellt eine der vielfältigsten und erfolgreichsten in der Geschichte der Säugetiere dar und war während ihrer vor nahezu 50 Millionen Jahren beginnenden Entwicklungsgeschichte über weite Teile Eurasiens, Afrikas und Nordamerikas verbreitet. Ihr Niedergang begann Ende des Miozäns vor rund 6 bis 5 Millionen Jahren in Verbindung mit klimatischen und damit einhergehenden Landschaftsveränderungen, die zum Aussterben der nordamerikanischen sowie zahlreicher weiterer Nashornvertreter im ursprünglichen Verbreitungsgebiet führten. Gegen Ende des Pleistozäns gab es eine erneute Aussterbephase, während der alle nordeurasischen Vertreter verschwanden. Überlebt haben die heute noch bestehenden Nashornarten Breitmaul- und Spitzmaulnashorn im Afrika südlich der Sahara sowie Panzer-, Java- und Sumatra-Nashorn im süd- bis südöstlichen Asien, die teilweise in ihrem Bestand aber stark bedroht sind.";
String testText = "Dies ist ein Test. Oh ja, ein Test bäm.";
  
StartnextProjectJSON project;
TextAnalyser ta;

void setup3(){
  ta = new TextAnalyser();
  TextInfo info = ta.analyse(testText);
  println("info.getNumberOfChars(): " + info.getNumberOfChars());
  println("info.getNumberOfWords(): " + info.getNumberOfWords());
  println("info.getNumberOfSentences(): " + info.getNumberOfSentences());
  MapUtil.printMap(info.getCharsPerSentenceMap());
}

void setup() {
  //Dbg.setDebugMode(true);
  project = new StartnextProjectJSON();
  project.loadFiles(FILENAME_BASE, SUFFIX, 0, 2000);
  //println(project.wc.dictionary);
  //project.printMostFrequentWords(20);
  //project.printMostFrequentWordsFundedOnly(20);
  //project.printMostFrequentWordsNotFundedOnly(20);
  

  // Write the JSON file.
  JSONObject json = project.wc.getDictionaryAsJSONObject(15);
  saveJSONObject(json, "test.json");
  JSONObject wordsPerMonth = project.wcPerMonth.getMonthsAsJSONObject(2);
  saveJSONObject(wordsPerMonth, "keywordsPerMonth.json");

  
  exit();
}
