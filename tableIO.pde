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
    int articleAge = row.getInt("articleAge");
    int shares = row.getInt("shares");
    //boolean alive = row.getBoolean("alive");
    // add an an alive col

    // Put article objects into the Hash Map
    articles.put(url, new Article(url, title, pubDate, articleID, section, commentCount, views, shares));
    table.removeRow(rowCount); // clear the table
    rowCount++;
  }
}

