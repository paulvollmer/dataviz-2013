import processing.data.*;

public class IntDictUtil{
  public static void printFirstNElements(IntDict dict, int n){
     if(n > dict.size()){
       System.err.println("printLastNElements(): n is too big! n: " + n + ", dict.size(): " + dict.size()); 
     }
     else if(dict.size() == 0){
       System.err.println("printLastNElements(): dict is empty!");
     }
     String[] keys = dict.keyArray();
     for(int i=0; i<n; i++){
       System.out.println("[" + i + "] " + keys[i]);    
     }
   }
   
   public static void printLastNElements(IntDict dict, int n){
     if(n > dict.size()){
       System.err.println("printLastNElements(): n is too big! n: " + n + ", dict.size(): " + dict.size()); 
     }
     else if(dict.size() == 0){
       System.err.println("printLastNElements(): dict is empty!");
     }
     int j = 0;
     String[] keys = dict.keyArray();
     for(int i = dict.size()-1; i>=dict.size()-n; i--){
       System.out.println("[" + j++ + "] " + keys[i]);    
     }
   }
}
