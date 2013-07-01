//class WordPerSentenceMgr{
//  HashMap funded, notFunded;
//  
//  public WordPerSentenceMgr(){
//    funded = new HashMap<Integer, Integer>();
//    nonFunded = new HashMap<Integer, Integer>();
//  }
//  
//  public void addToNonFunded(HashMap h){
//    putAndAdd(h, nonFunded);
//  }
//  
//  public void addToFunded(HashMap h){
//    putAndAdd(h, funded);
//  }
//  
//   /**
//   * Puts (if key does not exist) or adds (if key exists) all values from map **from** to map **to**
//   */
//  public void putAndAdd(Map<Integer, Integer> from, Map<Integer, Integer> to) { 
//    for (Map.Entry entry : from.entrySet()) {
//       
//      //System.out.println("Key = " +  + ", Value = " + entry.getValue());
//      Integer fromKey = (Integer)entry.getKey();
//      if(to.containsKey(fromKey)){
//        to.put(fromKey, to.get(fromKey) + from.get(fromKey));   
//      }
//      else{
//        to.put(fromKey, from.get(fromKey));
//      }
//    }
//  }
//}
