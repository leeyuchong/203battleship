// 203 Battleship Game Lab
// 2 March 2020
// Brian Lee, Jason Lee, Ling Xiu

import controlP5.*;
ControlP5 cp5;

int column=10;
int row=10;
int squareSize = 30;
int[][] fillColor = new int[column][row];
int shipsSunk = 5;
int shipsRemaining = 0;
String horizontalLabel = "";
String verticalLabel = "";
String helpText = "   It's your turn ! Click a square in the \n grid above to try and take down \nthe enemy ships !";
String instruction = "          Both players start with 3 ships that\n        take up 3, 6, and 9 squares each.\n      Remember, the ships could be in any\n    shape so long as they are contiguous.\n  Let's hope that you can hit the critical\n components (i.e. the cockpits, engines)\nfor a quicker takedown ! Good luck ! !";
String turnText = "PLAYER 1's Turn";
String shipsRemainingText = "Ships Remaining";
String statsLabelYours = "Yours: ";
String statsLabelOpp = "Opponent's: ";
String shipsSunkText = "Ships Sunk";


void setup() {
  // window size
  size(1536, 949);
  // a pic of the cockpit view over the blackness of the space 
  background(0);
  PImage background = loadImage("spaceship-cockpit-png-1.png");
  // size the image to fit the window
  image (background, 0, 0, 1536, 949);

  for (int i = 65; i<65+column; i++) {
    horizontalLabel+=(char)i;
    horizontalLabel+="        ";
  }

  for (int i = 1; i<=row; i++) {
    verticalLabel+=i+"\n";
  }

  cp5 = new ControlP5(this);



  // 3 potentially helpful buttons
  cp5.addButton("Settings")
    .setPosition(85, 650)
    .setSize(250, 30)
    .setColorActive(0xff53edef)
    .setColorBackground(0xff000000)
    .setColorForeground(0xff6c626a)
    .setFont(loadFont("Uroob-18.vlw"))
    ;


  cp5.addButton("Help")
    .setPosition(110, 700)
    .setSize(250, 30)
    .setColorActive(0xff53edef)
    .setColorBackground(0xff000000)
    .setColorForeground(0xff6c626a)
    .setFont(loadFont("Uroob-18.vlw"))
    ;

  cp5.addButton("Quit")
    .setPosition(135, 750)
    .setSize(250, 30)
    .setColorActive(0xff53edef)
    .setColorBackground(0xff000000)
    .setColorForeground(0xff6c626a)
    .setFont(loadFont("Uroob-18.vlw"))
    ;

  // column labels
  cp5.addTextlabel("horizontal label")
    .setText(horizontalLabel)
    .setPosition(617, 145)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-20.vlw"))
    ;
  // row labels
  textFont(loadFont("Uroob-20.vlw"));
  fill(0xff5edfe0);
  textAlign(RIGHT);
  textLeading(30);
  text(verticalLabel, 610, 185);
  
  // reminder text above the main dashboard
  cp5.addTextlabel("turn")
    .setText(turnText)
    .setPosition(700, 580)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-30.vlw"))
    ;

  // instructional text on the left panel of the main dashboard
  cp5.addTextlabel("instructions")
    .setText(helpText)
    .setPosition(590, 630)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-20.vlw"))
    ;
    
  cp5.addTextlabel("instructions2")
    .setText(instruction)
    .setPosition(553, 692)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-20.vlw"))
    ;

  // status text on the right panel of the main dashboard
  // information about the player making moves
  cp5.addTextlabel("p1")
    .setText(statsLabelYours)
    .setPosition(835, 630)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-30.vlw"))
    ;

  cp5.addTextlabel("p1ShipsSunkLabel")
    .setText(shipsSunkText)
    .setPosition(850, 660)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;

  cp5.addTextlabel("p1ShipsSunk")
    .setText(Integer.toString(shipsSunk))
    .setPosition(940, 660)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;

  cp5.addTextlabel("p1ShipsRemainingLabel")
    .setText(shipsRemainingText)
    .setPosition(850, 685)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;

  cp5.addTextlabel("p1ShipsRemaining")
    .setText(Integer.toString(shipsRemaining))
    .setPosition(945, 685)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;

  // information about the enemy player
  cp5.addTextlabel("p2")
    .setText(statsLabelOpp)
    .setPosition(835, 720)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-30.vlw"))
    ;

  cp5.addTextlabel("p2ShipsSunkLabel")
    .setText(shipsSunkText)
    .setPosition(850, 755)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;

  cp5.addTextlabel("p2ShipsSunk")
    .setText(Integer.toString(shipsSunk))
    .setPosition(960, 755)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;

  cp5.addTextlabel("p2ShipsRemainingLabel")
    .setText(shipsRemainingText)
    .setPosition(850, 780)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;

  cp5.addTextlabel("p2ShipsRemaining")
    .setText(Integer.toString(shipsRemaining))
    .setPosition(965, 780)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;
}

void draw() {
  // repaint a board with the correctly colored squares
  for (int i = 0; i<column; i++) {
    for (int j = 0; j<row; j++) {
      if (fillColor[i][j]==0)
        fill(0);
      else
        fill(255);
      stroke(94, 223, 224);
      square((width/2)-(squareSize*column/2)+i*30, (height/3)-(squareSize*column/2)+j*30, squareSize);
    }
  }
}

public void controlEvent(ControlEvent theEvent) {
  // feedback every time a button or a square is pressed
  println(theEvent.getController().getName());
}

void mousePressed() {
  // mouse clicks on the chosen positions
  if (mouseButton==LEFT) {
    int clickX = mouseX;
    int clickY = mouseY;
    int squareX = ((clickX-(width/2)+(squareSize*column/2))/30);
    int squareY = ((clickY-(height/3)+(squareSize*row/2))/30);
    if (mouseX>(width/2)-(squareSize*column/2) && mouseX<(width/2)+(squareSize*column/2) && mouseY>(height/3)-(squareSize*row/2) && mouseY<(height/3)+(squareSize*row/2)) {
      fillColor[squareX][squareY] = 1;
      print("Square hit: ("+(char)('A'+squareX)+", "+(1+squareY)+")\n");
    }
  }
}
