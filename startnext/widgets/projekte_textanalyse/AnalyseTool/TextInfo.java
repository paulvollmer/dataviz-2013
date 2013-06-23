import java.util.HashMap;

public class TextInfo{
  private int nChars, nWords, nSentences;
  private int avgCharsPerSentence, avgWordsPerSentence;
  private HashMap<Integer, Integer> charsPerSentenceMap;
  private HashMap<Integer, Integer> wordsPerSentenceMap;
  
  public TextInfo(){
    initVars();  
  }
  
  public void initVars(){
    nChars = -1;
    nWords = -1;
    nSentences = -1;
    avgCharsPerSentence = -1;
    avgWordsPerSentence = -1;
    charsPerSentenceMap = new HashMap<Integer, Integer>();
    wordsPerSentenceMap = new HashMap<Integer, Integer>();
  }
  
/*
 * ============================================================================
 * GETTERS
 * ============================================================================
 */  
  
  public int getNumberOfChars(){return nChars;}
  public int getNumberOfWords(){return nWords;}
  public int getNumberOfSentences(){return nSentences;}
  public int getAverageCharsPerSentence(){return avgCharsPerSentence;}
  public int getAverageWordsPerSentence(){return avgWordsPerSentence;}
  public HashMap<Integer, Integer> getCharsPerSentenceMap(){return charsPerSentenceMap;}
  public HashMap<Integer, Integer> getWordsPerSentenceMap(){return wordsPerSentenceMap;}
  
/*
 * ============================================================================
 * SETTERS
 * ============================================================================
 */  
 
 public void setNumberOfChars(int n){this.nChars = n;}
 public void setNumberOfWords(int n){this.nWords = n;}
 public void setNumberOfSentences(int n){this.nSentences = n;}
 public void setAverageCharsPerSentence(int n){this.avgCharsPerSentence = n;}
 public void setAverageWordsPerSentence(int n){this.avgWordsPerSentence = n;}
 public void setCharsPerSentenceMap(HashMap<Integer, Integer> map){this.wordsPerSentenceMap = map;}
 public void setWordsPerSentenceMap(HashMap<Integer, Integer> map){this.wordsPerSentenceMap = map;}
  
}
