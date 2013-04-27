/*  ephemeron 
 
 Alessandra Villaamil
 ITP Thesis 2013
 
 */

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.net.URLEncoder;
import java.util.Iterator;

PFont font;
PFont font2;
Object[] keys;
int k; // [k] position in HashMap
int articleAge;
int aniView;
int aniShare;
PrintWriter output;
Boolean drawText;

Table table;
HashMap <String, NYTapi> apis = new HashMap(); // storing API Keys
HashMap <String, Article> articles = new HashMap(); // storing article objects

ArrayList<Animal> animals = new ArrayList<Animal>(); // array list of animal objects
Animal animal;

Iterator iterator = articles.keySet().iterator();  

/* Setup
 ---------------------------------------------------------------- */

void setup() {
  size(1224, 968); // 1024, 768: keynote dimensions
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100); 
  background(360);
  font = loadFont("CourierNewPSMT-12.vlw");
  font2 = loadFont("CourierNewPSMT-14.vlw");
  drawText= true;

  apis.put("mostpop", new NYTapi("ff9024dab300f1b899643bc225c6dc4d:7:66899748", "mostpopular/v2/"));
  apis.put("community", new NYTapi("b6cc18e1be6bd5fa90374c712a3330c2:5:66899748", "community/v2/"));
  tableIO();
  loadNYT();

  // adding the animals to the array list 
  for (int i = 0; i < articles.size(); i++) {
    Article tempArticle = articles.get(keys[i]);
    tempArticle.save(table);
    animals.add(new Animal(tempArticle));
  }
  saveTable(table, "data/data.csv");
}


/* Draw
 ---------------------------------------------------------------- */

void draw() {

  animals.get(k).display(width/2, height/2);  // <--- draws animals
  animals.get(k).setColor();
  if (drawText) {
    drawText = false;
    animals.get(k).displayTags(); // <--- displays text
  }
}

/* Load Articles
 ---------------------------------------------------------------- */

void loadFromFile() {
  String[] lines = loadStrings("data.csv");
}

/* SaveImage
 ---------------------------------------------------------------- */

void saveImage(int theValue ) {
  println("Saving high quality image");
  save("savedfiles/EPHI_" + year() + "_" + month()+ "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + ".png");
  println("Saved");
}

/* KeyPressed
 ---------------------------------------------------------------- */

void keyPressed() {
  drawText = true;
  if (key == 's') saveImage(0);     
  if (key == CODED) {
    background(360);
    if (keyCode == RIGHT) {
      k++;
    } 
    else if (keyCode == LEFT) {
      k--;
    }
  }
  k = constrain(k, 0, keys.length-1);
}

