public class Dbg{
  private static boolean debugMode = true;
  
  public static void println(String s){
    if(debugMode){
      System.out.println("Debug Info: " + s);
    }
  }
  
  public static void setDebugMode(boolean b){
    debugMode = b;
  }
  
  public static boolean getDebugMode(){return debugMode;}
}
