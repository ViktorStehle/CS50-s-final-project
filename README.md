# CS50 computer science final project: Run Ghosty
#### Video Demo: https://www.youtube.com/watch?v=9m_efardPUM

![Screenshot_20230130_022842](https://user-images.githubusercontent.com/106766191/215550303-efb8038d-1a1b-4555-80db-bc727e251ddc.png)

#### Description: Run Ghosty is my first platformer demo. You are a little ghost trying to get out of the maze with only 3 lives. Throughout the maze, Ghosty will find various tasks to solve, such as dodging enemies, jumping over obstacles and small puzzles. It's your job as a player to make sure Ghosty finds his way out.

This is my final project for the CS50's Introduction to Computer Science

#### What you will find in this README
The idea,
rules and organization,
how to start and
explanation of the Elements

# The idea
While listening to this seminar for LÖVE and LUA and thinking about the CS50 classes, I very quickly got an idea of ​​where to go and what to do. The seminar helped me a lot to understand how to focus on the core and later on the extra (the landmines of game programming). Already, during the seminar, I decided on rules and guidelines for myself and my final project.

## The rules and the organization
1. Create a prototype
2. Time management
3. Focus on the core

#### 1. Create a prototype
I came up with the idea of ​​a game very quickly. I didn't want to depend too much on frameworks, so I decided to focus more on problem solving and understanding each element myself. The category I chose was survival. LÖVE has some incredible tutorials to get you started if you want to learn the language. Sheepolution gave me a very detailed tutorial about LOVE and I've used it quite a bit to solve problems I'm encountering.

#### 2. Time management
Giving myself a 2-week-limit of working and studying was quite a task. Make a small progress each day. Having a small goal set for each day to not waste time.

#### 3. Focusing on the core of the game was probably the most important part in getting things done fairly quick. I was distracted quite often and having my 3 rules written on a piece of paper next to me was very helpful in solving small problems and to not waste too much time.

# How to start?
A survival game is or can be very straight forward, but at the same time a lot of fun. So I listed what I want in my game:
### 1: entity
 #### 1.1: Character
 #### 1.2: Box
 #### 1.3: Enemies
 #### 1.4: Tiles
 #### 1.5: Cloud
 #### 1.6: Portal
### 2: Game
### 3: Main
### 4: Visual
### 5: Share
### 6: Game Over

### 1. The entity is meant to keep everything simple and keep all the pieces together inside. The entity gives shape to the elements and the values ​​they will end up using, and so on. First up is Entit:New() in this function you can create new tiles, objects and more and assign them basic values. Self is a part of LÖVE that allows you to refer to your own copy of an item like an enemy or a box where you can change various values. self.x and self.y are the display start of each element where to place them on the screen. Then we have the image to be displayed and where the image is coming from and the character's hitbox which is 25px wide and high. Lastly, you need to keep track of where the element should reset when a collision occurs to stop the elements from shaking and get a nice clean image. Strength is tracking how strong a character is for moving or immoble elements. tempStrength is an additional check to keep track of whether the element collides with an immoble element and therefore gets the extra strength for that duration of collision. Like a box hitting a wall while being pushed. BUT NOT ALWAYS! Only for the duration of the collision with the character. Gravity is set to make objects fall positively on the y and weight is the acceleration with which the item will fall. If the weight is zero, the element naturally remains on y, where it creates the illusion of levitation.

### The Entity:update(dt) function is to update the position of each single element each frame. In consideration of collision and also gravity. function Entity:draw() is to actually draw or print the different objects on the screen. function Entity:checkCollision(e) checks if different objects are colliding. "Entity" is first element and "e" is the second element to check where and how they are colliding. function Entity:resolveCollision(e) starts with a small check which element has a bigger strength for example to pushback or not beeing able to push back pushable elements. Then I check where the objects are colliding by taking the middle of the box on the x and y. Check where the middle of the second box is according to the first box. Collision is found on the "right", "left", "top" or "bottom". The strength is the value to check if the pushing element is pushed back (character hits a wall) or the element in the way is getting pushed back (character hits a box).

### function Entity:wasVerticallyAligned(e) is the check where the elements are colliding vertical and return the element which is moving into the other element. function Entity:wasHorizontallyAligned(e) is the same than vertically but just horizontally. function Entity:collide(e, direction) is the conclusion to all the checks of checkCollision and vertical or horizontally aligned. It takes all these inputs and creates the illusion for the user that a box is pushed. The Character stays where it is because it can't push the tile element back. And many more... Also included here is the "self.gravity = 0". If the gravity is not set to zero the Character, Enemy and Box will continuously accelerate until it is able to pass through the ground because the value increases to a point where it slips through the collision detection.

### Setting all these values for my elements I was able to create new elements with different values for different purposes. The whole setup for my characters are developed step by step while implementing the other elements like characters or enemies. While creating these elements I figured out similarities which allowed me to cut down on a lot of code and repetition.

1.1. Character: 
The character has it´s own values like strength for how strong it is compared to other elements. Speed to add to the x and y values, a liveCount for the lives and lastly a bollean canJump this value is to make sure that the character can only jump while being on the ground and to prevent multiple jumps in the air.

The update function of the character is to move the element around according to the user input "left" for decreasing the x-value and "right" for increasing the x-value. Inside I have to check for the last y-position and the current y-position. If this starts changing then we know the element is moving up or down on the y-value motion of falling. Change true to false of canJump to stop allowing the player to jump. Next up the function jump() we have to reduce the gravity temporarily to -150 on the y-value to create the illusion of jumping. While doing so we change the canJump to false to prevent the player from jumping again(otherwise you could create a small double jump because the doublejump detection of last.y takes a frame before being detected). 

function Character:collide(e, direction) We check if the character collides on it´s "bottom" side to reset the canJump if the player hits an element from the characters bottom side. The player can jump again. function Character:checkResolve(e, direction) is again a collision check and to check what is going to happen if collision occurs with different objects. Clouds: only allow collision from the top that creates the illusion that the character can jump through the cloud but will end up standing on it. Enemy: Resets the players position to the starting position and reduces the liveCount by 1. If the liveCount hits zero the game is over. Portal: currently because of time issues the portal resets the players position to the starting position. For the future it is supposed to set the player to another position, to the next level or to the "you won" screen.

1.2. Box: The Box was the example of moving elements around with the collision of the character element. It was the basic idea for collision and what to do with collision, also to increase collision if the character pushed the box and the box hits the wall. This is where I had to spend most of my time figuring out the problem and coming up with ideas for collision and collisionResolve. The box only has the proberties of the entity because the entity is designed very flexible and simple.

1.3. Enemies: The enemies are the same as the box. Able to interact with other objects checking collision but having it's own value. The speed value gives the enemy element the ability to run around. I could add more values to create different types of enemies. Setting the weight value to zero to create the illusion of floating enemies. Or a canJump value to give the element the illusion of continuously jumping. The resolveCollisiong function does the same as the function of the character. With the exception that if it collides "left" or "right" with a tile, the enemy will change it's x value to -x (creates the illusion of turning around).

1.4. Tiles: The tiles are also an extend of the entity, it has the same values but some of them are changed. First, the strength value is set to 100. This allows me to compare this value to other elements like the box or the character. It is not the tile which is pushed back, it will be the character or the box. The weight is for creating the illsuion of gravity. Gravity is programmed so it doesn't interact with the tiles value to prevent the tiles from falling out of the screen.

1.5. Cloud: The cloud is the same as the tile set changed values to create the illusion of flying but I decided on another class because the cloud should be able to be passed through from "left", "right" and "bottom", but to be able to stand on top of it. It has the same properties and could be removed from the class table and put into the tiles. To keep the classes clean I decided on a separate class.

1.6. Portal: The Portal also has the same elements as the entity but it starts moving around the character by collision. It also has weight set to zero for the float illusion and can be used to jump inside a stage or move on to the next stage. (Currently not fully implemented because of time issues.)

### 2. Game: The game class is where everything in the game is going to happen. The game is where everything is fed into the functions. From character, tiles, cloud, enemie. Everything can be used and is put in context to each other.

The function Game:new() sets the mood of the game, it provides tables for the game to store different elements. The object table provides a table for the character and different boxes. We also have the enemy table. Why are we creating so many tables? Different tables have a different purpose for our collision and for other things to be clearer. I separated them to make sure my logic follows through. The design itself is definitly something to work on because of repetition. The map is a table with numbers in it, these numbers describe different types of elements fed into the table. Why would you fix settle a world and don't randomize? Well, every old game has their own charm by creating a world which always remains the same, doesn't matter how many times you play it. And every time you play, you discover something else which you did not know before (I prefer this personal touch of memorable stages and worlds). 1 represents tiles, 2 represents clouds, 3 represents enemies, 4 represents portal and 5 is for the boxes. I chose this design because I can easily represent the fix world the way I want to (also leaves open future possibilities for sandbox). With the double loop I iterate over each single element in the table and feed the "i" which represent the x value -1 * 25 pixels into the class to great the necessary class in the x position and "j" as the y value -1 * 25. This creates squares, while 25 is the width and the height of each element. According to the number the output will be a tile, cloud, enemie or box. The problem I encountered was to load and unload each map for each world and moving between world or erasing enemies becomes quite difficult. I created a lot of bugs and had to cancel quite some ideas because it didn't quite work the way I intended it to.

function Game:update(dt) this function is to update each single element in the game. Since my game is a demo I update all the elements inside the game step by step. For a game of a bigger size, a slow pc or with multiple levels this would be very problematic. But for the demo this works and was a quick solution not to invest too much time for the design. While this function checks each single element it also requests the collision of all these elements to see where, when and what is colliding. Tiles are not checking to collide with each other for example to reduce the amount of information used. 

function Game:draw() in this part we go into each element from the map and update the elements. It loops over each table and prints the necessary class on the screen and consistently updates it. 

### 3. Main: I seperate the "main" from the "game". This is where I wanted to start separating and think more into the future. The Core was set and now I can start looking into details. To set a "Menu" you could write it into the game function but that will quickly go out of hand. So separating the "Main" or "Menu" into different parts from the "game" makes it easier to sort and figure out new features and implementations. "Main" also stitches all the classes together with the help of classic also a function which comes from lua to connect different classes together.

### 4. Visual: After getting the core done and thinking more and more about different extras I could implement. I started with the most obvious one. I had Blue(character), Red(Enemie), Green(box) and White(tiles and clouds) squares of the size x=25pixel and y=25pixel and that in itself was to simple. But it helped me quite a lot with collision and thinking about a hitbox of different elements. So I decided on a funny start-asset with ghosts (no animation needed for now), a box, simple stonetiles and many more. My game started to look more and more like a game not just like a prototype. 

### 5. Sharing: Furthermore, I was thinking of how can I actually share this game with others and make it more like a game. Luckily Lua and Love have a build in function to work with. The t sets the game Icon to a new Icon like the ghost and also changes the name of the program. function love.conf(t) is storing all this information and makes the whole game useable without having visual studio code, love and lua on the pc. 

### Game Over: Finally, this project is finished. Writing this Readme about the game and the experience I had creating this game was very fun. I strictly hold on to my rules and even went over my code again, trying to express in words what I was trying to implement, how it works and what my thought process was. I found mistakes, bugs, ideas and other things I could have easily changed. But I decided as a first project and for having limited time I was happy with the outcome. I decided to leave it as it is to have a great reference for the future. Where did I start -> How did I finish this Course -> Where am I going to be in the upcoming future. 

I highly appreciate this CS50 project,big thanks to all the people which put so much effort in creating this possibility and I hope that many more people are able to hold on to it and get a better picture of how programming works, what a PC is and what a blessing it is to have it already so far developed. 
