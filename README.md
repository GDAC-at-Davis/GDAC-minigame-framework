# GDAC Minigame Project
A game project where collections of minigames are linked together and increase in difficulty. GDAC members are encouraged to add their own minigames to this project.

## Project Specifications
* Godot Version: 4.5
* Window Size: 1280 x 720

## Minigame Contribution Guide
### Examples
[Balloon Popper](https://github.com/GDAC-at-Davis/GDAC-minigame-framework/blob/4c6ed3adcabfe8e865ec73166f50ec56712f8f0a/MinigameFramework/minigames/balloon_popper/) is an example of a full minigame.

[Test 3D](https://github.com/GDAC-at-Davis/GDAC-minigame-framework/blob/4c6ed3adcabfe8e865ec73166f50ec56712f8f0a/MinigameFramework/minigames/test_3d/) is an example of a barebones minigame using 3D assets.

### Steps
1. Clone the repository to your local device.
2. Create a new branch off of the dev branch for your minigame in the github.
3. Create a folder for your minigame in the [minigames folder](https://github.com/GDAC-at-Davis/GDAC-minigame-framework/blob/4c6ed3adcabfe8e865ec73166f50ec56712f8f0a/MinigameFramework/minigames/). Make sure to give it a proper name. Everything for your minigame should be added to this folder.
4. Add a new scene to your folder and change its type to Minigame. This is the main scene that will represents and controls your minigame.
5. Add a new script to your folder that extends the Minigame class and attach the script to the Minigame scene. The specifications for the Minigame class can be found below.
6. Add a new MinigameInfo resource to your folder. Fill out the resource with the name of your minigame and the icon it will appear with in the Minigame Collection. The scene data entry should be the scene for your minigame that you created in step 3.
7. You should now be able to play your minigame from the Minigame Collection.
8. Commit and push your changes to your branch.
9. Create a pull request from your branch to the dev branch when your minigame is completed.

## Minigame Class Specifications
The [Minigame class](https://github.com/GDAC-at-Davis/GDAC-minigame-framework/blob/4c6ed3adcabfe8e865ec73166f50ec56712f8f0a/MinigameFramework/scripts/minigame.gd) provides the framework for minigames to properly communicate with the Minigame Manager. Currently, a new instance of the minigame is created each time a minigame is played but this may change in the future for performance. It is recommended to reset variables and other relevant data in the start() function.

### Exported Variables
These are variables you may edit inside of the inspector.
* instruction - Instruction that displays at the start of the minigame.
* countdown_time - Time in seconds until the minigame ends. Will call lose() if the player hasn't won by the time this ends. Set this to 0 or any negative value to disable. Usually keep this around 5 seconds.
* skip_time - Time in seconds to skip the countdown timer to when the minigame ends.

### Managed Variables
These variables are managed by the Minigame Manager. You should only read these variables, do not manually change their values.
* difficulty - Represents the current difficulty level of the minigame. You will have to implement how your minigame scales with difficulty. For example, a value of 2.0 should roughly translate to the minigame being twice as difficult.
* has_won - True if the player has won the minigame.
* has_ended - True after win() or lose() is called.

### Abstract Functions
These are abstract functions you may override with your own implementation. They are automatically called at certain times.
* start() - This is called once at the start of the minigame. It would be good practice to reset all of your variables in this function.
* run() - This is called 60 times per second.
* end() - This is called after win() or lose() is called.
* complete() - This is called when the countdown timer finishes.

### Callable Functions
These are functions meant to be called inside your code. If you override these functions, make sure to call their super() function.
* win() - Call this whenever a win condition is met.
* lose() - Call this whenever a lose condition is met. This is also automatically called when the countdown timer finishes.