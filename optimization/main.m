close all
% clear all

% declare global variables
global robot
global xd
global Rd

drc4();

% define desired position and orientation of right wrist
xd = [0.3 -0.1 0.5];
Rd = eye(3);

% define options for fmincon optimization
options = optimset('Algorithm','interior-point','MaxFunEvals',1000000,'MaxIter',1000);

% initial guess for the solution (all joint angles)
p0(1:28) = [joint(2:29).angle];
p0(29:31) = joint(1).position_w;
p0(32:35) = [0,0,0,1];


% Set the constraints for joint limits
for ii = 1:28
    ub(ii,1) = robot.j(ii+1).angle_limits(2);
    lb(ii,1) = robot.j(ii+1).angle_limits(1);   
end

%root position
ub(29:31,1) = [1;1;2];
lb(29:31,1) = [-1;-1;0];

%root orientation
lb(32:35,1) = 5*[-1;-1;-1;-1];
ub(32:35,1) = 5*[1;1;1;1];
lb(36) = 0;
ub(36) = 1;
p0(36) = 1;

% start timer
t_start = tic;

% run optimization
[answer,fval,exitflag]=fmincon(@criterion,p0,[],[],[],[],lb,ub,@constraints,options);

% stop timer
t_end = toc(t_start);


fprintf('Time to solve: %f Seconds\n',t_end);
fprintf('Objective Value: %f\n',fval);

% -------- Recover variables from parameters --------- %

% set robot's joints to current parameter joint angles
for i = 1:28
    robot.j(i+1).angle = answer(i);
end

% set the robot's base link to the proper world coordinates and
% orientation
robot.j(1).position_w = answer(29:31);
robot.j(1).rotation = q_to_R(answer(32:35));

% Solve forward kinematics using optimized joint angle solutions
[robot, robot_com, robot_mass] = drc_forward_kinematics( robot );

% plot Atlas robot pose
figure
draw(robot,xd,robot_com);
title('Final');

