import java.util.Map;
import java.util.Iterator;

public class MapUtil{
  /**
   * Helper function to print out the contents of a HashMap
   */
  public static void printMap(Map mp) {
    Iterator it = mp.entrySet().iterator();
    while (it.hasNext ()) {
      Map.Entry pairs = (Map.Entry)it.next();
      System.out.println(pairs.getKey() + " = " + pairs.getValue());
      it.remove(); // avoids a ConcurrentModificationException
    }
  }
}
