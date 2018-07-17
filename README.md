# tic-tac-toe

Tic tac toe project as a THP assignment to learn OOP

Two players can duel each other in a tic tac toe game, no AI

Peer-coders : Kamus, Fadia

### About the classes

- Board : initialized with the game, status full, no-full, contains methods to check if 3 ticks are aligned or if the board is full
- BoardCase : a case on the board, 3 status : x, o and empty, initialized at board creation
              no logic attached
- Player : one per player, should be initialized when game starts, has a name and a tick type
- Game : should start the player and board, contains the game logic (methods to play the game)
