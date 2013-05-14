/* TableIO - in & out
 
 this function fills table with csv data and saves to Hash Map
 ---------------------------------------------------------------- */

void tableIO() {
  // Load CSV file into a Table object
  table = loadTable("data.csv", "header");

  int rowCount = 0;
  for (TableRow row : table.rows()) {
    String url = row.getString("url");
    String title = row.getString("title");
    String pubDate = row.getString("pubDate");
    String articleID = row.getString("articleID");
    String section = row.getString("section");
    int commentCount = row.getInt("commentCount");
    int views = row.getInt("views");
    int shares = row.getInt("shares");

    // Put article objects into the Hash Map
    articles.put(url, new Article(url, title, pubDate, articleID, section, commentCount, views, shares));
    //table.removeRow(rowCount); // < --- this produces duplicate files in the table
    rowCount++;
  }
  
  for (int i = rowCount-1; i >= 0; i--) {
     table.removeRow(i); //   < --- this only includes articles i'm getting from the api
  }
}

