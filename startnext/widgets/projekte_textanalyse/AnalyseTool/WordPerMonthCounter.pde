import java.util.Date; 

class WordPerMonthCounter

{  
  HashMap<String, WordCounter> months;

  WordPerMonthCounter()
  {
    months = new HashMap<String, WordCounter>();
  }

  void countWordsInMonth(String content, long timestamp)
  {
    Date d = new Date(timestamp*1000);
    String hashIndex = (d.getYear() + 1900) + "-" +  (d.getMonth()+1);

    WordCounter wcResult = months.get(hashIndex);
    if (wcResult != null) {
      wcResult.countWords(content);
      Dbg.println("known month: " +  hashIndex);
    } else {
      Dbg.println("unknown month: " + hashIndex);
      WordCounter wcNew = new WordCounter();
      wcNew.countWords(content);
      months.put(hashIndex, wcNew);
    }
  }

  JSONObject getMonthsAsJSONObject(int threshold) {

    Iterator it = months.entrySet().iterator();
    JSONObject result = new JSONObject();
    JSONArray months = new JSONArray();

    int i = 0;
    while (it.hasNext ())
    {
      Map.Entry pairs = (Map.Entry) it.next();
      String keyResult =  (String) pairs.getKey();
      WordCounter wcResult = (WordCounter) pairs.getValue();
      JSONObject month = new JSONObject();
      JSONArray words = wcResult.getDictionaryAsJSONObject(threshold).getJSONArray("words");
      month.setString("year-month", keyResult);
      month.setJSONArray("words", words);
      months.setJSONObject(i, month);
      i++;
      it.remove();
    }
    result.setJSONArray("months", months);
    println(result);
    return result;
  }
}

