/* LoadNYT APIs
 
 This function grabs data and puts it in a HashMap
 ---------------------------------------------------------------- */

void loadNYT() {

  println("Getting data from nytimes...\n");

  // ------ Most Shared ------
  XML request = apis.get("mostpop").getQuery("mostshared/all-sections/twitter;facebook;email/1.xml");
  XML[] results = request.getChild("results").getChildren();

  //int counter = 1;
  for (int i = 0; i < results.length; i++) {
    XML temp = results[i];

    String url = temp.getChild("url").getContent();
    String title = temp.getChild("title").getContent();
    String pubDate = temp.getChild("published_date").getContent();
    String articleID = temp.getChild("asset_id").getContent();
    String shares = temp.getChild("total_shares").getContent();  
    String section = temp.getChild("section").getContent();

    Article tempArticle = new Article(url, title);
    tempArticle.setDate(pubDate);
    tempArticle.setArticleID(articleID);
    tempArticle.setShares(shares);
    tempArticle.setSection(section);
    tempArticle.alive = true;

    if (shares != "0") {
      articles.put(url, tempArticle);
    }
    println("request 1: grabbed a share!");
  }

  // ------ Most Viewed ------
  request = apis.get("mostpop").getQuery("mostviewed/all-sections/1.xml");
  results = request.getChild("results").getChildren();

  for (int i = 0; i < results.length; i++) {
    XML temp = results[i];

    String url = temp.getChild("url").getContent();
    String title = temp.getChild("title").getContent();
    String views = temp.getChild("views").getContent();
    String pubDate = temp.getChild("published_date").getContent();
    String articleID = temp.getChild("id").getContent();
    String section = temp.getChild("section").getContent();

    Article thisArticle;

    //If articles are already in HashMap from most shared request
    if (articles.containsKey(url)) {
      thisArticle = articles.get(url);
      thisArticle.setViews(views);
      thisArticle.setDate(pubDate);
      thisArticle.alive = true;
    } 
    //If article is not in most shared, but is in most viewed
    else {
      thisArticle = new Article(url, title, views);
      thisArticle.setDate(pubDate);
      thisArticle.setArticleID(articleID);
      thisArticle.setSection(section);
      thisArticle.alive = true;

      if (views != "0") {
        articles.put(url, thisArticle);
      }
    }
    println("request 2: grabbed a view!");
  }

  // ------ Setting HashMap ------
  println("\n" + "ORIGINAL hash size is " + articles.size() + "\n");

  keys = articles.keySet().toArray();
  int removeCounter = 1;
  for (int i = 0; i < keys.length; i ++) {
    //println(keys[i]);
    int articleViews = articles.get(keys[i]).views;
    int articleShares = articles.get(keys[i]).shares;

    if (articleViews == 0 || articleShares == 0) {
      //println(removeCounter + " -=REJECTED=-");
      removeCounter++;
      articles.remove(keys[i]);
    }
  }

  // ------ Printing the data! ------
  int articleCounter = 0;
  for (int i = 0; i < keys.length; i ++) {
    keys = articles.keySet().toArray(); // resetting keys with accepted articles
    articleCounter++;
    println("[" + articleCounter + "]" + " " + articles.get(keys[i]).title + ", " + articles.get(keys[i]).pubDate + ", " + articles.get(keys[i]).section);
    println("ani still most pop? " + articles.get(keys[i]).alive);
    println("views: " + articles.get(keys[i]).views + " // shares: " + articles.get(keys[i]).shares + " // comments: " + articles.get(keys[i]).commentCount + "\n");
  }
  println("\n" + "CLEANED hash size is " + articles.size() + "\n");

  // ------ iterate through HashMap keys ------ a different way of iterating with the java iterator class
  Iterator iterator = articles.keySet().iterator();  
  while (iterator.hasNext ()) {  

    String key = iterator.next().toString();
    String valueDate = articles.get(key).pubDate;
    String valueID = articles.get(key).articleID; 
    String valueSection = articles.get(key).section; 
    int articleViews = articles.get(key).views;
    int articleShares = articles.get(key).shares;
    //println("article: " + key + " [DATE] " + valueDate + " [ID] " + valueID + " [SECTION] " + valueSection);
    //println ("views: " + articleViews + " && shares: " + articleShares);
  }
  println("-------------------");
}

