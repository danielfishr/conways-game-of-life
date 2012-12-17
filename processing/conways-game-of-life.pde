/*  Implementation of Conway's Game of Life
 *  
 *  Configurable via variables
 *  GENERATIONS_PER_SECOND - speed of the game
 *  GRID_SIZE - height and widrth in pixels
 *  CELL_SIZE - height and width in pixels
 *  INITIAL_CELL_COUNT - number of initial cells to highlight
 *
 */

int GRID_SIZE = 401;
int CELL_SIZE = 20;
int INITIAL_CELL_COUNT=200;
int GENERATIONS_PER_SECOND = 5;

int TABLE_LENGTH = GRID_SIZE/CELL_SIZE;
boolean[][] cells = new boolean[TABLE_LENGTH][TABLE_LENGTH];
boolean[][] nextCells = new boolean[TABLE_LENGTH][TABLE_LENGTH];

void setup(){
  size(GRID_SIZE, GRID_SIZE);
  background(0, 0, 0);
  stroke(255);
  frameRate(GENERATIONS_PER_SECOND);
  drawGrid();
  initialCells();
}

void draw(){ 
  conwayIteration();
}

void conwayIteration()
{
  for(int x=0;x<TABLE_LENGTH;x++)
  {
    for(int y=0;y<TABLE_LENGTH;y++)
    {
        nextCells[x][y] = false;
        int count = 0; 
        if(getCell(x-1,y))   count++; 
        if(getCell(x-1,y+1)) count++;
        if(getCell(x-1,y-1)) count++;
        if(getCell(x,y-1))   count++;
        if(getCell(x+1,y-1)) count++;
        if(getCell(x+1,y))   count++;
        if(getCell(x+1,y+1)) count++;
        if(getCell(x,y+1))   count++;
        if(count < 2) nextCells[x][y] = false;
        if(count >= 2 && count <= 3 && cells[x][y]) nextCells[x][y] = true; 
        if(count > 3 && cells[x][y]) nextCells[x][y] = false;
        if(count == 3 && !cells[x][y]) nextCells[x][y] = true;
    }
  } 

  clearCells();
 
  for(int x=0;x<TABLE_LENGTH;x++)
    for(int y=0;y<TABLE_LENGTH;y++)
      if(nextCells[x][y]) colorCell(x,y); 
}

void initialCells(){
  for(int i=0;i<INITIAL_CELL_COUNT;i++)
    colorCell(randCoord(),randCoord()); 
}

int cellRowCount()
{
  return GRID_SIZE/CELL_SIZE;  
}

void drawGrid(){
  for(int i = CELL_SIZE;i<GRID_SIZE; i = i+CELL_SIZE){
    line(0, i, GRID_SIZE, i);
    line(i, 0, i, GRID_SIZE);  
  }
}

boolean getCell(int x,int y)
{
  if(x > TABLE_LENGTH-1) x = x-TABLE_LENGTH; 
  if(y > TABLE_LENGTH-1) y = y-TABLE_LENGTH;
  if(x < 0) x = x + TABLE_LENGTH;
  if(y < 0) y = y + TABLE_LENGTH;
  return cells[x][y];
}

void colorCell(int x,int y,int colour)
{
  fill(colour);
  rect(x*CELL_SIZE,y*CELL_SIZE,CELL_SIZE,CELL_SIZE);
  cells[x][y] = true; 
}

void clearCell(int x,int y){
  fill(0);
  rect(x*CELL_SIZE,y*CELL_SIZE,CELL_SIZE,CELL_SIZE);  
}

void colorCell(int x,int y)
{
  colorCell(x,y,102);
}

void clearCells(){
  for(int i=0;i<TABLE_LENGTH;i++)
  {
    for(int j=0;j<TABLE_LENGTH;j++)
    {
      cells[i][j] = false;
      clearCell(i,j);
    }
  }  
}

int randCoord(){
  return int(random(0,TABLE_LENGTH)); 
}

/*spaceship*/
void glider()
{
  colorCell(10,10);
  colorCell(11,10);
  colorCell(12,10);
  colorCell(12,9);
  colorCell(11,8);  
}
