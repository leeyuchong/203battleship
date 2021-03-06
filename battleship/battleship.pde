//battleship test interface by Jason Lee, Brian Lee and Lingxiu Zhang

//Actions: click on the grid to select grid items, click on quit to quit interface.
//Other buttons currently do not do anything.

//Console will display grid object selected, and button pressed.

//controlP5 library
import controlP5.*;
ControlP5 cp5;

//grid variables
int column=10;
int row=10;
int squareSize = 30;
int[][] fillColor = new int[column][row];

//interface variables
int shipsSunk = 5;
int shipsRemaining = 0;
String horizontalLabel = "";
String verticalLabel = "";

//interface text
String helpText = "   It's your turn ! Click a square in the \n grid above to try and take down \nthe enemy ships !";
String instruction = "          Both players start with 3 ships that\n        take up 3, 6, and 9 squares each.\n      Remember, the ships could be in any\n    shape so long as they are contiguous.\n  Let's hope that you can hit the critical\n components (i.e. the cockpits, engines)\nfor a quicker takedown ! Good luck ! !";
String turnText = "PLAYER 1's Turn";
String shipsRemainingText = "Ships Remaining";
String statsLabelYours = "Yours: ";
String statsLabelOpp = "Opponent's: ";
String shipsSunkText = "Ships Sunk";


void setup() {
  //window size
  size(1536, 949);
  
  //a pic of the cockpit view over the blackness of the space 
  background(0);
  PImage background = loadImage("spaceship-cockpit-png-1.png");
  
  //size the image to fit the window
  image (background, 0, 0, 1536, 949);
  
  //set up column labels (A to J)
  for (int i = 65; i<65+column; i++) {
    horizontalLabel+=(char)i;
    //eight spaces per label
    horizontalLabel+="        ";
  }
  
  //set up row labels (1 to 10)
  for (int i = 1; i<=row; i++) {
    verticalLabel+=i+"\n";
  }
  
  //initialize controlP5 object
  cp5 = new ControlP5(this);

  //settings button- does not do anything at the moment
  cp5.addButton("Settings")
    .setPosition(85, 650)
    .setSize(250, 30)
    .setColorActive(0xff53edef)
    .setColorBackground(0xff000000)
    .setColorForeground(0xff6c626a)
    .setFont(loadFont("Uroob-18.vlw"))
    ;

  //help button- does not do anything at the moment
  cp5.addButton("Help")
    .setPosition(110, 700)
    .setSize(250, 30)
    .setColorActive(0xff53edef)
    .setColorBackground(0xff000000)
    .setColorForeground(0xff6c626a)
    .setFont(loadFont("Uroob-18.vlw"))
    ;

  //quit button- does not do anything at the moment
  cp5.addButton("Quit")
    .setPosition(135, 750)
    .setSize(250, 30)
    .setColorActive(0xff53edef)
    .setColorBackground(0xff000000)
    .setColorForeground(0xff6c626a)
    .setFont(loadFont("Uroob-18.vlw"))
    ;

  //column labels- cp5 object
  cp5.addTextlabel("horizontal label")
    .setText(horizontalLabel)
    .setPosition(617, 145)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-20.vlw"))
    ;
  //row labels- cp5 object
  textFont(loadFont("Uroob-20.vlw"));
  fill(0xff5edfe0);
  textAlign(RIGHT);
  textLeading(30);
  text(verticalLabel, 610, 185);
  
  //reminder text above the main dashboard
  cp5.addTextlabel("turn")
    .setText(turnText)
    .setPosition(700, 580)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-30.vlw"))
    ;

  //instructional text on the left panel of the main dashboard
  cp5.addTextlabel("instructions")
    .setText(helpText)
    .setPosition(590, 630)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-20.vlw"))
    ;
    
  //instructional text on the left panel of the main dashboard
  cp5.addTextlabel("instructions2")
    .setText(instruction)
    .setPosition(553, 692)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-20.vlw"))
    ;

  //status text on the right panel of the main dashboard
  //information about the player 1 making moves
  cp5.addTextlabel("p1")
    .setText(statsLabelYours)
    .setPosition(835, 630)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-30.vlw"))
    ;

  //status text on right dashboard panel for player 1: "Ships Sunk"
  cp5.addTextlabel("p1ShipsSunkLabel")
    .setText(shipsSunkText)
    .setPosition(850, 660)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;

  //status: number of ships player 1 has sunk
  cp5.addTextlabel("p1ShipsSunk")
    .setText(Integer.toString(shipsSunk))
    .setPosition(940, 660)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;
    
  //status text right dashboard panel for player 1: "Ships Remaining"
  cp5.addTextlabel("p1ShipsRemainingLabel")
    .setText(shipsRemainingText)
    .setPosition(850, 685)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;

  //status: number of ships player 1 has remaining
  cp5.addTextlabel("piShipsRemaining")
    .setText(Integer.toString(shipsRemaining))
    .setPosition(945, 685)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;

  //information about player 2
  cp5.addTextlabel("p2")
    .setText(statsLabelOpp)
    .setPosition(835, 720)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-30.vlw"))
    ;

  //"Ships Sunk" text for player 2
  cp5.addTextlabel("p2ShipsSunkLabel")
    .setText(shipsSunkText)
    .setPosition(850, 755)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;

  //number of ships player 2 has sunk
  cp5.addTextlabel("p2ShipsSunk")
    .setText(Integer.toString(shipsSunk))
    .setPosition(960, 755)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;
    
  //"Ships remaining" text for player 2
  cp5.addTextlabel("p2ShipsRemainingLabel")
    .setText(shipsRemainingText)
    .setPosition(850, 780)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;

  //number of ships player 2 has remaining
  cp5.addTextlabel("p2ShipsRemaining")
    .setText(Integer.toString(shipsRemaining))
    .setPosition(965, 780)
    .setColorValue(0xff5edfe0)
    .setFont(loadFont("Uroob-16.vlw"))
    ;
}

void draw() {
  
  //draws a new board with the right colored squares
  for (int i = 0; i<column; i++) {
    for (int j = 0; j<row; j++) {
      if (fillColor[i][j]==0) {
        fill(0);
      }
      else {
        fill(255);
      }
      
      stroke(94, 223, 224);
      //draw square with location of square x and square y
      square((width/2)-(squareSize*column/2)+i*30, (height/3)-(squareSize*column/2)+j*30, squareSize);
    }
  }
}

//notification line every time a button is pressed or a square is pressed
public void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getName());
}

//quit when the Quit button has been pressed
public void Quit() {
  exit();
}

void mousePressed() {
  // where the mouse clicks will affect the colors of the squares to indicate chosen positions
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
