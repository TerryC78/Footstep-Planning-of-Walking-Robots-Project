function [ joint_angle ] = GenerateFootTraj(x_d, y_d, numStep, step_freq, num)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% walking trajectory 
%-------------------------------------------
direction = 'fr';
step_d = [x_d y_d]; % 0.3
step_h = 1; % 1
step_w = 1; % 1

% footstep planning
[x1,x2,y1,y2,z1,z2] = footStep(step_d,step_h, step_w,num,direction,'m','m');
%------------------------------------------- 

% manipulating trajectory -----------------
% used for limbs that are 'manipulating' not walking
% x3 = .2*ones(1,num);
% y3 = linspace(-.15,.15,num);
% z3 = .05*ones(1,num);
%-------------------------------------------

% total trajectory (a,b represents the two groups of three legs in the
% tripod gait)

% Generate hexagon leg configuration for better
% stability/maneuverability
hexY = .2;
hexX = -.1;
% combine input parameters for gaitController()
hexXY = [hexX, hexY];
trajectory = [x1;x2;y1;y2;z1;z2]; % footstep position

% gaitController() uses IK() to calculate joint angles for given trajectory for the tripod gait depending on which direction is specified
% returns trajectory
joint_angle = gaitController(trajectory, hexXY, direction, num); % joint angle (hip/joint/ankle, leg#, sequence)

end

