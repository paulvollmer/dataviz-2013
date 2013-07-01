class ProjectInfo{
  TextInfo teaserTextInfo;
  TextInfo answersTextInfo;
  int nTags; // number of tags
  boolean successful;
  
  public ProjectInfo(){
    nTags = -1;
    teaserTextInfo = new TextInfo();
    answersTextInfo = new TextInfo();
    successful = false;
  }
}
