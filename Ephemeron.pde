/*  
 Alessandra Villaamil
 ITP Thesis 2013                                     
          _                             
  ___ ___| |_ ___ _____ ___ ___ ___ ___ 
 | -_| . |   | -_|     | -_|  _| . |   |
 |___|  _|_|_|___|_|_|_|___|_| |___|_|_|
     |_|                                
 
 */

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.net.URLEncoder;
import java.util.Iterator;

PFont courier12;
PFont courier14;
PFont courier18;
PFont courier16;
Object[] keys;
int k; // [k] position in HashMap
int articleAge;
int aniView;
int aniShare;
Boolean drawText;

PImage img;


Table table;
HashMap <String, NYTapi> apis = new HashMap(); // storing API Keys
HashMap <String, Article> articles = new HashMap(); // storing article objects

ArrayList<Animal> animals = new ArrayList<Animal>(); // array list of animal objects
Animal animal;

Iterator iterator = articles.keySet().iterator();  

/* Setup
 ---------------------------------------------------------------- */

void setup() {
  size(1224, 968);//(displayWidth, displayHeight);//(1224, 968);//(1224, 918); //(1278, 721);// 1024, 768: keynote dimensions
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100); 
  background(360);
  courier12 = loadFont("CourierNewPSMT-12.vlw");
  courier14 = loadFont("CourierNewPSMT-14.vlw");
  courier18 = loadFont("Courier-18.vlw");
  courier16 = loadFont("Courier-16.vlw");
  drawText= true;
  
//  img = loadImage("foram1x.jpg");
//  background(img);
  
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
    //background(img);
    if (keyCode == RIGHT) {
      k++;
    } 
    else if (keyCode == LEFT) {
      k--;
    }
  }
  k = constrain(k, 0, keys.length-1);
}


