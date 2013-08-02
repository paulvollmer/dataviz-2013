import java.util.Arrays;
import java.util.HashMap;

class TextAnalyser{
  private static final char[] sentenceTerminators = {'.', '!', '?'};
  
  String text;
  TextInfo textInfo;
  
  public TextInfo analyse(String s){
    clear();
    this.text = s;
    textInfo = new TextInfo();
    // count characters
    countChars(text);
    int nChars = countChars(text);
    textInfo.setNumberOfChars(nChars);
    // count words
    int nWords = countWords(text);
    textInfo.setNumberOfWords(nWords);
    // do sentence analysis
    doSentenceAnalysisAndStoreResults(text, textInfo);
    return textInfo;
  }
  
  // reset everything
  public void clear(){
    text = null;
    textInfo = null;
  }

/*
 * ============================================================================
 * GETTERS
 * ============================================================================
 */  
 
  public TextInfo getTextInfo(){
    if(textInfo == null){
      System.err.println("getTextInfo(): You need to call analyse() before, returning null.");
    }
    return textInfo;
  }
  
/*
 * ============================================================================
 * SPECIFIC TEXT ANALYSIS FUNCTIONS
 * ============================================================================
 */
 
 /**
  * Returns the number of charcaters in a string 
  * (including special chars and whitespace).
  */
 private int countChars(String s){
   return s.length();
 }
 
  /**
   * Returns the number of words. Return value equals number of whitespaces+1.
   */
  private int countWords(String s){
    int n = 0;
    for(char c: s.toCharArray()){
      if(c == ' '){
        n++;
      }
    }
    return ++n; // add the last word and return
  }
  
  /**
   * Counts the number of sentences in the text based on sentence terminators (! ? .). 
   * Creates a HashMap with the frequency of words per sentence <words per sentence, frequency> 
   * and chars per sentence <chars per sentence, frequency>.
   * The results are stored in a TextInfo object 
   */
  public void doSentenceAnalysisAndStoreResults(String s, TextInfo textInfo){
    HashMap charsPerSentenceMap = textInfo.getCharsPerSentenceMap();
    HashMap wordsPerSentenceMap = textInfo.getWordsPerSentenceMap();
    int iStart = 0, iEnd = -1;
    int nSentences = 0;
    
    while((iEnd = getNextSentenceTerminatorIndex(s, iStart)) != -1){
      String sentence = s.substring(iStart, ++iEnd);
      Dbg.println(sentence);
      // store number of chars in map
      int nChars = countChars(sentence);
      Dbg.println("Number of Chars: " + nChars);
      if(charsPerSentenceMap.containsKey(nChars)){
        charsPerSentenceMap.put(nChars, (Integer)(charsPerSentenceMap.get(nChars))+1); // Increment value by one
      }
      else{
        charsPerSentenceMap.put(nChars, 1);
      }
      // store number of words in map
      int nWords = countWords(sentence);
      Dbg.println("Number of Words: " + nWords);
      if(wordsPerSentenceMap.containsKey(nWords)){
        wordsPerSentenceMap.put(nWords, (Integer)(wordsPerSentenceMap.get(nWords))+1); // Increment value by one
      }
      else{
        wordsPerSentenceMap.put(nWords, 1);
      }
      iStart = getNextNonWhitespaceChar(s, iEnd);
      
      // increment sentence counter
      nSentences++;
    }
    Dbg.println("Number of Sentences: " + nSentences);
    textInfo.setNumberOfSentences(nSentences);
  }  
  
/*
 * ============================================================================
 * HELPER FUNCTIONS - CHARACTER SEARCH
 * ============================================================================
 */
 
  /**
   * Returns the index of the next sentence terminator (. ! ?) 
   * starting from index startIndex.
   */
   private int getNextSentenceTerminatorIndex(String s, int startIndex){
    int[] indexes = new int[sentenceTerminators.length];
    for(int i=0; i<indexes.length; i++){
      indexes[i] = s.indexOf(sentenceTerminators[i], startIndex);
    }
    return getSmallestNonNegativeValue(indexes);  
  }
  
  /**
   * Returns the index of the whitespace character
   */
  private int getNextNonWhitespaceChar(String s, int startIndex){
    int i = startIndex;
    while(i < s.length() && s.charAt(i) == ' '){
      i++;
    }
    return i;
  }
  
  /**
   * Returns the smallest value within the array which is not negative
   */
  private int getSmallestNonNegativeValue(int[] arr){
    Arrays.sort(arr);
    reverse(arr); // [10, 9, 8, 7,...]
    
    int min = -1;
    for(int a: arr){
      if(a > -1){
        min = a;
      }
    }
    return min;
  }
 
/*
 * ============================================================================
 * HELPER FUNCTIONS - ARRAYS
 * ============================================================================
 */ 
  
  /**
   * Reverses the elements of an array.
   */
  public void reverse(int[] data) {
    for (int left = 0, right = data.length - 1; left < right; left++, right--) {
      int temp = data[left];
      data[left]  = data[right];
      data[right] = temp;
    }
  }
} // end class
