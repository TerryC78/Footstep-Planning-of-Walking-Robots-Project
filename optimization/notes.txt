% load robot
drc4

% all angles are zero. Pelvis is at right height.
draw( robot ) % crude picture

% see if calculated locations match load file.
[ robot1 robot_com robot_mass ] = drc_forward_kinematics( robot );

% check against original input, should be zero or very small numbers
for i = 1:29
robot1.j(i).position_w - robot.j(i).position_w
end

for i = 1:29                                  
robot1.l(i).com_w - robot.l(i).com_w          
end

% set root variables
robot.j(1).position_w = [ 0 0 0.92712 ];
robot.l(1).orientation = q_to_R( [ 0 0 0 1 ] );

% set robot joint angles
robot.j(2).angle = 0.279899;
robot.j(3).angle = 0.0239405;
robot.j(4).angle = -0.0456667;
robot.j(5).angle = 0.0290229;
robot.j(6).angle = -0.263555;
robot.j(7).angle = 0.0158942;
robot.j(8).angle = -0.7;
robot.j(9).angle = -0.8;
robot.j(10).angle = -0.9;
robot.j(11).angle = 1;
robot.j(12).angle = 0.0158875;
robot.j(13).angle = -0.262659;
robot.j(14).angle = -0.0298684;
robot.j(15).angle = 0.0595606;
robot.j(16).angle = -0.0223973;
robot.j(17).angle = 0.279003;
robot.j(18).angle = 0.6;
robot.j(19).angle = 0.5;
robot.j(20).angle = 0.4;
robot.j(21).angle = 0.3;
robot.j(22).angle = 0.2;
robot.j(23).angle = 0.1;
robot.j(24).angle = -0.65;
robot.j(25).angle = -0.55;
robot.j(26).angle = -0.45;
robot.j(27).angle = -0.35;
robot.j(28).angle = -0.25;
robot.j(29).angle = -0.15;

% do forward kinematics
[ robot2 robot_com robot_mass ] = drc_forward_kinematics( robot );
draw( robot2 );

