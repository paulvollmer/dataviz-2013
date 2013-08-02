class TagCounter{
  IntDict tags;
  
  TagCounter(){
    tags = new IntDict();
  }
  
  void addTag(String tag){
    if(tags.hasKey(tag)){
      tags.increment(tag);
    }
    else{
      tags.set(tag, 1);
    }
  }
  
  JSONArray getJsonArray(int threshold) {
    JSONArray arr = new JSONArray();
    int i = 0;
    for (String k : tags.keys()) {
      if (tags.get(k) >= threshold) {
        JSONObject tag = new JSONObject();
        tag.setString("text", k);
        tag.setInt("weight", tags.get(k));
        arr.setJSONObject(i, tag);
        i++;
      }
    }
    return arr;
  }
}
