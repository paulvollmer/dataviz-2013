class WordCounter {

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
      String word = words[i];
      word.toLowerCase();
      checkWord(word);
    }
  }


  void checkWord(String word)
  {
    int occurrence = dictionary.get(word);
    if (occurrence > 0) {
      dictionary.add(word, 1);
      //println("known word --- "+ word + " --- " + occurrence+1);
    } else {
      dictionary.set(word, 1);
      //println("new word ---- "+ word);
    }
  }
}

