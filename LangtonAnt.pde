// Create a 2D array for the grid
int[][] grid;
// each cell is 4x4 pixel
int cellSize = 4;
// the whole grid is 125x125 cells
int gridSize = 125;
int cellStartX = 0;
int cellStartY = 0;

// enumerate directions
int left = 0;
int right = 1;
int up = 2;
int down = 3;
int[][] move; // hold the rules to move

// initial ant position and direction
int antRow = 62;
int antCol = 62;
int antDir = up;

// when done stop the simulation
boolean done = false;
int[] colDelta = {-1,1,0,0};
int[] rowDelta = {0,0,-1,1};
int iter = 1;
PFont font;


// initialize the data structure
void initialize(){
   move = new int[4][2];
   grid = new int[gridSize][gridSize];
   
   // make every cell white
   for(int i = 0; i < gridSize; i ++)
      for(int j = 0; j < gridSize; j ++)
        grid[i][j] = 0;
   
   // specify the rules to move
   // such as left 90 degree + left 90 degree
   // results in down 180 degree
   move[left][left] = down;
   move[right][left] = up;
   move[up][left] = left;
   move[down][left] = right;
   move[left][right] = up;
   move[right][right] = down;
   move[up][right] = right;
   move[down][right] = left;
}

void setup(){
  // setup the canvas
  background(255);
  size(500,500);
  frameRate(120);
  // create Pfont object to render text
  font = createFont("FreeMonoBold.ttf", 20);
  textFont(font);
  initialize();
}

void draw(){
  // this is the main loop
  background(255);
  drawBoard();
  move();
  // I used below line to make video of the
  // simulation. It saves the frames in a 
  // folder called farmes. Then used the 
  // MovieMaker tool in Tools option to
  // create the actual video.
  //saveFrame("frames/#####.tga");
}

void move(){
  // compute the next move 
  println("iter: " + iter++);
  if (!done){ // if simulation is still running
     // compute the next direction
     int dir = move[antDir][grid[antRow][antCol]];
     
     // toggle the current cell
     grid[antRow][antCol] = 1 - grid[antRow][antCol];
     
     // update the ant's position
     // some very very CLEVER use 
     // of data structure here
     antCol += colDelta[dir];
     antRow += rowDelta[dir];
     antDir = dir;
  }    
  if(antRow < 0 || antRow >= gridSize || 
      antCol < 0 || antCol >= gridSize)
    done = true; // when ant is out of grid
}

void drawBoard(){
  // computer graphics function to 
  // plot the grid and ant
  noStroke();
  // draw each cell of the grid
  for(int i = 0; i < gridSize; i ++)
    for(int j = 0; j < gridSize; j ++){
      if(grid[j][i] == left)
        fill(255); // white
      else if(grid[j][i] == right)
        fill(127); // gray
      rect(cellStartX + i * cellSize,
        cellStartY + j * cellSize,
        cellSize, cellSize);
    }
  fill(255,0,0); // Red Ant 
  rect(cellStartX + antCol * cellSize,
    cellStartY + antRow * cellSize,
    cellSize, cellSize);
  
  fill(0,0,255);
  text(" Simulation of Langton's Ant", 10, 20);
  fill(0,255,0);
  text("   Step: " + iter, 330, 20);
 
}