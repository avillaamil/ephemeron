class Article {

  /* This class constructs an article object from data grabbed in the loadNYT function.
   ---------------------------------------------------------------- */

  String title = "Untitled", url = "URL", pubDate ="####-##-##", articleID = "#", section = "###";
  int commentCount = 0, views = 0, articleAge = 0, shares = 0;
  boolean alive = false; // checks if article is still in most popular database
  Date date;

  Article(String _url) {
    url = _url;
    views = 0;
    reqCommentCount();
  }

  Article(String _url, String _title) {
    url = _url;
    title = _title;
    reqCommentCount();
  }

  Article(String _url, String _title, String _views) {
    url = _url;
    title = _title;
    setViews(_views);
    reqCommentCount();
  }

  // for table: how can i calculate articleAge here?
  Article(String _url, String _title, String _pubDate, String _articleID, String _section, int _commentCount, int _views, int _shares) {
    url = _url;
    title = _title;
    setDate(_pubDate);
    articleID = _articleID;
    section = _section;
    commentCount = _commentCount;
    views = _views;
    shares = _shares;
  }

  /* Setting Meta Data functions
   ---------------------------------------------------------------- */

  void setSection(String _section) {
    section = _section;
  }

  void setArticleID(String _articleID) {      
    articleID = _articleID;
  }

  void setShares(String _shares) {
    shares = int(_shares);
  }

  void setTitle(String _title) {
    title = _title;
  }

  void setViews(String _views) {
    views = int(_views);
  }

  void setDate(String _date) {
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    pubDate = _date;

    try {
      date = df.parse(pubDate);
      long articleMS = date.getTime();
      long nowMS = new Date().getTime();
      long betweenMS = nowMS - articleMS;
      articleAge = (int)betweenMS/1000/60/60/24;   //calculated as days
      //println("This article is " + articleAge + " days old.");
    } 
    catch (Exception e) {
      println("Unable to parse date stamp " + _date + " " + e);
    }
  }

  /* Getting Comments
   ---------------------------------------------------------------- */

  void setCommentCount(String _commentCount) {
    commentCount = int(_commentCount);
  }

  void reqCommentCount() {
    String encodedURL = URLEncoder.encode(url);
    String[] params = {
      "url=" + encodedURL
    };

    XML request3 = apis.get("community").getQuery("comments/url/exact-match.xml", params);
    try {
      if (request3.getChild("status").getContent().indexOf("OK") != -1 ) {
        //println(request3.getChild("results").getChild("totalCommentsFound").getContent());
        setCommentCount(request3.getChild("results").getChild("totalCommentsFound").getContent());
      }
    } 
    catch (Exception e) {
      println(url + " NO COMMENTS");
      setCommentCount("0");
    }
    println("request 3: got a comment!");
  }

  /* Saving Data to the Table
   ---------------------------------------------------------------- */
   
  void save(Table t) {
    TableRow row = table.addRow();

    // Set the values of that row
    row.setString("url", url); 
    row.setString("title", title);
    row.setString("pubDate", pubDate);
    row.setString("articleID", articleID);
    row.setString("section", section);
    row.setInt("commentCount", commentCount);
    row.setInt("views", views);
    row.setInt("shares", shares);
  }
}

