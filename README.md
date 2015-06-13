# Footstep-Planning-of-Walking-Robots-Project
Research project
Footstep planning code

To run the code,
- first add the four folders "Learning the Terrain, HighLevelPlan, LowLevelPlan, Trajectory Optimization" and their subfolders into path 
- then open “hexapod_bodyrugged.slx”
- finally run "RunSnakeMonsterSimulator.m"



A* on flag ground
(1) turn left, turn right

   y 
   |            0.19   0.25  -0.16    hexX = -0.1
   |            0.29  -0.05  -0.16    hexY =  0.2
   |            0.19  -0.15  -0.16    stanceX = 0.29
--- -------> x
r  |
o  |
b  |
o  |
t  |

       x         y         z
1   0.1900    0.2500   -0.1600
4   0.2900   -0.0500   -0.1600
5   0.1900   -0.1500   -0.1600
2   0.1900   -0.1500   -0.1600
3   0.2900   -0.0500   -0.1600
6   0.1900    0.2500   -0.1600


low level planning
(1) cost function

(2) search , constraints

(3) generate trajectory


function:
any terrain height map => 100 by 100  matrix
given 100 by 100 matrix => 
first classify n both high level and lower level
(1)  high level: body path
(2)  low level: next 4 steps

good rough terrain visualization (scale)
have a cost map (10 by 10 and 100 by 100)
search and plan for the six legs
send the footstep to the robot and generate trajectory


