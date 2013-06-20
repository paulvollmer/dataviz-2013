/**
 * Text analyse algorythms.
 */
class TextAnalyse {
  
  /**
   * Constructor
   */
  TextAnalyse() {}

  int totalChars() {
    return 0;
  }
  
  int totalWords(String input) {
    String split[] = splitTokens(input);
    for(int i=0; i<split.length; i++) {
      println("["+i+"] "+split[i]);
    }
    return split.length;
  }

  

}
