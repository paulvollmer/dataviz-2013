public class PrintUtil{
  private static final String line = "===================================================================";
  private static final String newline = System.getProperty("line.separator");
  
  public static void printHeader(String s){
    System.out.println(newline + line + newline + s + newline + line + newline);  
  }
  
  public static void printHeader(Object o){
    printHeader(o.toString());
  }
  
  public static void printErrHeader(String s){
    System.err.println(newline + newline + line + newline + s + newline + line + newline);  
  }
  
  public static void printErrHeader(Object o){
    printErrHeader(o.toString());
  }
}
