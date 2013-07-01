/**
 * A simple WordCounting Object. It creates a Dictionary of Words can be fed with Strings and counts the occurence of every word. 
 */


class WordCounter
{


  IntDict dictionary;


  WordCounter()
  {
    dictionary = new IntDict();
  }


  void countWords(String content)
  {
    String[] words = content.split(" ");
    for (int i=0; i<words.length; i++)
    {

      // TODO: The Filter also destroys emoticons — that makes me ;-(
      String word = words[i];
      word.toLowerCase();
      word = word.replace("!", "");
      word = word.replace(".", "");
      word = word.replace("?", "");
      word = word.replace("\"", "");
      word = word.replace(":", "");
      word = word.replace(";", "");
      word = word.replace(",", "");
      word = word.replace("/", "");
      word = word.replace("(", "");
      word = word.replace(")", "");
      word = word.replace("[", "");
      word = word.replace("]", "");
      word = word.replace("\n", "");
      word = word.replace("\t", "");
      checkWord(word);
    }
  }


  void checkWord(String word)
  {
    int occurrence = dictionary.get(word);
    if (occurrence > 0) {
      dictionary.add(word, 1);
    } else {
      dictionary.set(word, 1);
    }
  }


  JSONObject getDictionaryAsJSONObject(int threshold) {
    // Write the JSON file.
    JSONObject result = new JSONObject();
    JSONArray values = new JSONArray();

    int i = 0;
    for (String k : dictionary.keys()) {
      if (dictionary.get(k) >= threshold) {
        JSONObject word = new JSONObject();
        word.setString("name", k);
        word.setInt("count", dictionary.get(k));
        values.setJSONObject(i, word);
        i++;
      }
    }
    result.setJSONArray("words", values);
    return result;
  }
}

