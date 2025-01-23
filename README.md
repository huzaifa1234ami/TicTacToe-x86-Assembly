# Tic-Tac-Toe in Assembly Language  

This repository contains the assembly language implementation of the popular **Tic-Tac-Toe** game. It is a text-based, console-friendly version designed for two players. The program highlights the use of low-level instructions for input handling, grid rendering, and game logic.

---

## **Features**  

1. **Interactive Gameplay**:  
   Players input their moves, and the program updates the game board in real time.  

2. **Grid Rendering**:  
   A clean and simple 3x3 grid design is displayed in the console, showing the current state of the game after each turn.  

3. **Turn-Based System**:  
   Alternates turns between Player 1 and Player 2, ensuring a fair game flow.  

4. **Win Detection**:  
   - Horizontal, vertical, and diagonal win conditions are checked after every move.  
   - The game announces the winner when a win condition is met.  

5. **Draw Detection**:  
   If the grid is filled without any winner, the game concludes with a "Draw" message.  

6. **Assembly-Level Programming**:  
   Written in pure assembly language, leveraging direct memory management, register operations, and interrupt handling.  

---

## **Technical Details**  

### **Core Functionalities**  

1. **Grid Representation**:  
   - The game board is stored in memory and updated dynamically after each move.  
   - The grid uses a simple coordinate system, allowing players to choose positions using numbered cells.

2. **Player Input**:  
   - Players enter their moves by selecting the desired cell.  
   - Input validation ensures that players cannot overwrite previously marked cells.

3. **Win Logic**:  
   - The program evaluates all possible winning conditions after every turn.  
   - Uses assembly-level branching and logical operations to determine game outcomes.

4. **Draw Logic**:  
   - If no winning condition is met and all cells are occupied, the game declares a draw.

5. **Console Display**:  
   - The game uses text-based visuals to render the grid, with clear labels and updates after each move.
