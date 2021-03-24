# The state of the app at any given time

## The app itself needs information about ...

- Has the game started or are we in the menu or have we just won/lost a game? **Game: gameStatus** (which is an enum of type **GameStatus**)

## The playing area

- How many points has the player already? **Game: points** (int)
- Which blocks are currently seeable? **Game: positionShape** (which is a Map (associative array) which will translate every **Position** to the **Shape** it holds; shapes that are not on that map are not seeable)
- Which block is currently moving? **Game: activeShape** (of type **Shape**)

## One block

- What is your form? **Shape: relPositions** (which is a List of **Position**s that descrive the position of each block relative to the **Position** of the shape itself. Furthermore, **Shape: relPositionsArray** is a List of all relative positions that shape could ever have through rotation)
- ~~What is your position?~~ We already have that information in the playing area (**Game**). We do not need to have it in two different locations. Otherwise, we would always have to both state indicators whenever a position changes. I have to admint that I'm still not sure about the fractional vertical movement.
- What is your color? (**Shape: color**)

(to be continued)
