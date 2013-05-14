class Animal {

  /* Local Variables
   ---------------------------------------------------------------- */

  Article ani;
  ArrayList<PVector> pointList = new ArrayList<PVector>();
  PVector temp1;
  PVector temp2;
  Boolean stopDrawing = false; //  < ----- for views count
  int i = 0; //                    < ----- iterates drawn lines               
  int i1 = 0;
  int pointCount = 0;
  float noiseCount = 0;
  float minDistance = 10; 
  float lineWeight = 1;
  float lineAlpha = 50;
  float connectionRadius = 150;
  float d, a, h;
  float numPoints = 200;
  float pointDegree = 360 / numPoints; 
  float randomness = 100; 

  //Article values  
  float ccrandCOS; //              < ----- comments mapped to cos
  float ccrandSIN; //              < ----- comments mapped to sin
  float radius; //                 < ----- share mapped to size  
  float drawing; //                < ----- views mapped to drawing
  float hueValue; //               < ----- color mapped to section
  float saturationValue = 100;  
  float brightnessValue = 100;

  /* Animal Constructor
   ---------------------------------------------------------------- */

  Animal() {
  }

  Animal(Article _ani) {
    ani = _ani;
  }

  /* Display
   ---------------------------------------------------------------- */

  void display(float xPos, float yPos) {
    pushMatrix();
    translate(xPos, yPos);

    // ------ mapping article data to draw vars ------
    drawing = map(ani.views, 42000, 300000, 0, 2000);
    radius = map(ani.shares, 400, 3000, 50, 400);
    ccrandCOS = map(ani.commentCount, 0, 900, 2, 3);
    ccrandSIN = map(ani.commentCount, 0, 900, .2, .5);

    i++;                                                    
    if (i > drawing) {
      i = 0;
      stopDrawing = true;
    }

    // ------ set points                                        
    float n = random(randomness);
    //float n = noise(noiseCount) * randomness; // < ------  perlin noise
    int rand = (int)random(3);
    float x =0;
    float y=0;
    //println(rand);

    //if (rand == 1) {
    if (ani.commentCount >= 60) {
      x = cos(radians(pointDegree * i * (random(ccrandCOS)))) * (radius + n);
      y = sin(radians(pointDegree * i * ccrandSIN)) * (radius + n);
    }
    // else if (rand ==2) {
    else if (ani.commentCount > 20 && ani.commentCount < 60) {
      x = acos(radians(pointDegree * i * (random(ccrandCOS)))) * (radius + n);
      y = asin(radians(pointDegree * i * ccrandSIN)) * (radius + n);
    }
    // else {
    else if (ani.commentCount <= 20) {
      x = tan(radians(pointDegree * i * (random(ccrandCOS)))) * (radius + n);
      y = tan(radians(pointDegree * i * ccrandSIN)) * (radius + n);
    }

    //float f = tan(radians(pointDegree * i * (random(ccrandCOS)))) * (radius + n);
    //float g = tan(radians(pointDegree * i * ccrandSIN)) * (radius + n);
    noiseCount += 1;  

    // ------ connecting points
    minDistance = map(ani.commentCount, 0, 1000, 0, 10);
    if (pointCount > 0) { // as long as there's a point
      PVector p = (PVector) pointList.get(pointCount - 1);
      if (dist(x, y, p.x, p.y) > (minDistance)) {
        pointList.add(new PVector(x, y));
      }
    } 
    else {
      pointList.add(new PVector(x, y));
    }
    pointCount = pointList.size();

    // ------ draw everything ------
    strokeWeight(lineWeight);
    stroke(360, lineAlpha); // < ----- alpha depends on distance of the points  
    strokeCap(ROUND);

    int drawEndTime = millis() + 100; // < ----- performance timer

    if (!stopDrawing) { 
      while (i1 < pointCount && millis () < drawEndTime) {
        beginShape();
        vertex(0, 0);
        for (int i2 = 0; i2 < i1; i2++) {
          PVector p1 = (PVector) pointList.get(i1);
          PVector p2 = (PVector) pointList.get(i2);
          drawLine(p1, p2);
        }
        i1++;
        vertex(0, 0);
        endShape();
      }
    }
    popMatrix();
  }

  /* DrawLine function 
   ---------------------------------------------------------------- */

  void drawLine(PVector p1, PVector p2) {
    d = PVector.dist(p1, p2);
    a = pow(1 / (d / connectionRadius + 1), 6);

    if (d <= connectionRadius) { // <------ filler  
      h = map(1 - a, 0, 1, 0, 100) % 360; // minHueValue & maxHueValue
      noFill();
      stroke(0);
      stroke(hueValue+h, saturationValue, brightnessValue, a*lineAlpha + (i1 % 2 * 2));
      line(p1.x, p1.y, p2.x, p2.y);
    }
  }

  /* SetColor // section data
   ---------------------------------------------------------------- */

  void setColor() {
    //println(ani.section + " " + hueValue);

    if (ani.section.equals("U.S.")) { // green 
      hueValue = 10;
    }
    if (ani.section.equals("World")) { // acqua 
      hueValue = 70;
    }
    if (ani.section.equals("N.Y. / Region")) { // red
      hueValue = 330;
    }
    if (ani.section.equals("Opinion")) { // super green
      hueValue = 50;
    }
    if (ani.section.equals("Health")) { // purple pink
      hueValue = 240;
    }
    if (ani.section.equals("Magazine")) { // red purple
      hueValue = 270;
    }
    if (ani.section.equals("Business Day")) { // purple blue
      hueValue = 200;
    }
    if (ani.section.equals("Style")) { // yellow green
      hueValue = 105;
    }
    if (ani.section.equals("Arts")) { // purple
      hueValue = 170;
    }
    if (ani.section.equals("Sports")) { 
      hueValue = 130;
    }
    if (ani.section.equals("Books")) { // super red
      hueValue = 90;
    }
    if (ani.section.equals("Movies")) {
      hueValue = 290;
    }
    if (ani.section.equals("Technology")) { // magenta
      hueValue = 220;
    } 
    if (ani.section.equals("Science")) { // very blue
      hueValue = 150;
    }
    if (ani.section.equals("Dining & Wine")) {
      hueValue = 20;
    }
    if (ani.section.equals("Obituaries")) { 
      hueValue = 300;
    }
    if (ani.section.equals("Politics")) { 
      hueValue = 280;
    }
    if (ani.section.equals("Travel")) {
      hueValue = 210;
    }
    if (ani.section.equals("Home & Garden")) {
      hueValue = 190;
    }
    if (ani.section.equals("Weather")) {
      hueValue = 250;
    }

    // ------ dead settings ------
    if (ani.alive == 0) {
      hueValue = 150;
      saturationValue = 0;
      brightnessValue = 75;
    }
  }

  /* DisplayTags 
   ---------------------------------------------------------------- */

  void displayTags() {
    String aniTitle = articles.get(keys[k]).title;
    String id = articles.get(keys[k]).articleID;
    String alive = "EPHEMERON";
    String dead = "ephemeron fossil";
    String aniDate = articles.get(keys[k]).pubDate;
    String aniSection = articles.get(keys[k]).section;
    int aniIndex = k+1; // starts the index at the 1st position
    int aniAge = articles.get(keys[k]).articleAge;
    int aniView = articles.get(keys[k]).views;
    int aniShare = articles.get(keys[k]).shares;
    int aniComment = articles.get(keys[k]).commentCount;

    textFont(courier14, 14);
    fill(0); 
    text(aniTitle, 50, 50);

    textFont(courier12, 12); 
    fill(100);
    text("[" + aniIndex + "]", 10, 50); // position in array
    text(alive + " " + id, 50, 70);
    text("D.O.B. " + aniDate + "  //  " + aniAge + " day(s) old", 50, 110);
    text("Location: " + aniSection, 50, 130);
    text(aniView + " views", 50, 150);
    text(aniShare + " shares", 50, 170);
    text(aniComment + " comments", 50, 190);

    // ------ set death 
    if (ani.alive == 0) {
      //textAlign(CENTER);
      String ephi = " Here Lies Ephemeron ";
      String obit = "-= May it rest peacefully archived =-";
      textFont(courier14, 14);
      fill(0); 
      text(ephi + " " + ani.articleID, width/2 - 150, height/2 + 70);
      text(obit, width/2 - 150, height/2 + 100);
      textFont(courier12, 12);
      text(aniView + " people looked at you, " + aniShare + " shared your story and " + aniComment + " wrote to you.", width/2 - 250, height/2 + 230);
    }

    // ------ set timestamp 
    long time = System.currentTimeMillis();
    Date date = new Date(time);
    String readableDate = new SimpleDateFormat("EEE, MMM d, yyyy 'at' HH:mm:ss a").format(date);
    textFont(courier14, 14);
    text(readableDate, 920, 50);
 }
}

