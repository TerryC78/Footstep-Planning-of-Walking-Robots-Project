function [ x1,x2,y1,y2,z1,z2 ] = footStep( stepDistance, stepHeight, stepWidth, num, stepType, stanceHeight,stanceBase)
% Generates continuous footstep trajectory based on input step distance
% using Monte Carlo Optimization Method
% INPUT: stepDistance = distance traveled with each step
%        stepHeight = max height of each foot trajectory
%        stepWidth = distance leg moves toward chassis during flight phase
%        num = # of points (resolution of the trajectory)
%        stepType = 'f' - forward, 'b' - backward, 'r' - right, 'l' - left
%        stanceHeight = 'h' high, 'm' medium, or 'l' low
%                                    OR
%                       between .04 (low stance) and .31 (high stance)
%        stanceBase = 'h' high, 'm' medium, or 'l' low
%                                    OR
%                     between .2 (narrow stance) and .37 (wide stance)
%
% Author: Simon Kalouche
% BioRobotics Lab


if nargin < 7
    stanceBase = 'm';
end

if nargin < 6
    stanceHeight = 'm';
    stanceBase = 'm';
end

if nargin < 5
    stepType = 'f';
    stanceHeight = 'm';
    stanceBase = 'm';
end

if nargin < 4
    num = 100;
    stepType = 'f';
    stanceHeight = 'm';
    stanceBase = 'm';
end

if nargin < 3
    stepWidth = 1;
    num = 100;
    stepType = 'f';
    stanceHeight = 'm';
    stanceBase = 'm';
end

if nargin < 2
    stepHeight = 1;
    stepWidth = 1;
    num = 100;
    stepType = 'f';
    stanceHeight = 'm';
    stanceBase = 'm';
end

if (stepHeight > 1 || stepHeight < 0)
    disp('Error: Step Height input is not valid');
end

if (stepWidth > 1 || stepWidth < 0)
    disp('Error: Step Width input is not valid');
end

if isa(stanceHeight, 'char')
    % set stance height based on input
    if (stanceHeight == 'h')
        stanceZ = -.22;
    elseif (stanceHeight == 'm')
        stanceZ = -.16;
    elseif (stanceHeight == 'l')
        stanceZ = -.04;
    end
elseif isa(stanceHeight, 'numeric')
    stanceZ = stanceHeight;
end

if isa(stanceBase, 'char')
    % set stance base based on input
    if (stanceBase == 'h')
        stanceX = .37;
    elseif (stanceBase == 'm')
        stanceX = .29;
    elseif (stanceBase == 'l')
        stanceX = .2;
    end
elseif isa(stanceBase, 'numeric')
    stanceX = stanceBase;
end

%% Forward Walking
% x and z are similar 
% for y:
% leg1 = leg5 = -leg4 = -[y1 y2]
% leg2 = leg6 = -leg3 =  [y2 y1]

if stepType == 'f'
    % stance phase for leg2
    x1 = stanceX*ones(1,num/2);
    y1 = linspace(-stepDistance(2)/4,stepDistance(2)/4,num/2);
    z1 = stanceZ*ones(1,num/2);
    % flight phase for leg2
    y2 = linspace(stepDistance(2)/4,-stepDistance(2)/4,num/2);
    x2 = stepWidth*(1/stepDistance(2)^2)*(y2.^2);
    z2 = -stepHeight*(1.5/(norm(stepDistance))^2)*(y2.^2);

    % calculate x and z position differences inbetween phases to make the
    % trajectory continous
    diffX = x1(1)-x2(end);
    diffZ = z1(1)-z2(end);

    % adjust x and z values
    x2 = x2+diffX; % (x2 = x2 - x2(end) + x1(1))
    z2 = z2+diffZ;
    
end

%% Backward Walking
if stepType == 'b'
    % stance phase
    x1 = stanceX*ones(1,num/2);
    y1 = linspace(stepDistance(2)/4,-stepDistance(2)/4,num/2);
    z1 = stanceZ*ones(1,num/2);
    % flight phase
    y2 = linspace(-stepDistance(2)/4,stepDistance(2)/4,num/2);
    x2 = stepWidth*(1/stepDistance(2)^2)*(y2.^2);
    z2 = -stepHeight*(1.5/(norm(stepDistance))^2)*(y2.^2);

    % calculate x and z position differences inbetween phases to make the
    % trajectory continous
    diffX = x1(1)-x2(end);
    diffZ = z1(1)-z2(end);

    % adjust x and z values
    x2 = x2+diffX;
    z2 = z2+diffZ;
    
end

%% Sidestep Right
% y and z are similar for every leg
% for x:
% leg1 = leg5 = -leg4 = [x2 x1]
% leg2 = leg6 = -leg3 = [x1 x2]
if stepType == 'r'
    % stance phase for leg2
    y1 = zeros(1,num/2);
    x1 = linspace(-stepDistance(1)/4,stepDistance(1)/4,num/2);
    z1 = stanceZ*ones(1,num/2);
    % flight phase for leg2
    x2 = linspace(stepDistance(1)/4,-stepDistance(1)/4,num/2);
    y2 = zeros(1,num/2);
    z2 = -stepHeight*(1.5/(norm(stepDistance))^2)*(x2.^2);

    % calculate x and z position differences inbetween phases to make the
    % trajectory continous
    diffX = x1(1)-x2(end);
    diffZ = z1(1)-z2(end);

    % adjust x and z values
    x2 = x2+diffX;
    z2 = z2+diffZ;
    
    x1 = x1+.8*stanceX;
    x2 = x2+.8*stanceX;
    
end

%% Sidestep Left
% 
if stepType == 'l'
    % stance phase
    y1 = zeros(1,num/2);
    x1 = linspace(-stepDistance(1)/4,stepDistance(1)/4,num/2);
    z1 = stanceZ*ones(1,num/2);
    % flight phase
    x2 = linspace(stepDistance(1)/4,-stepDistance(1)/4,num/2);
    y2 = zeros(1,num/2);
    z2 = -stepHeight*(1.5/(norm(stepDistance))^2)*(x2.^2);

    % calculate x and z position differences inbetween phases to make the
    % trajectory continous
    diffX = x1(1)-x2(end);
    diffZ = z1(1)-z2(end);

    % adjust x and z values
    x2 = x2+diffX;
    z2 = z2+diffZ;
     
    x1 = x1+.8*stanceX;
    x2 = x2+.8*stanceX;
    
end

%% Forward-Right walking
% same thing
if strcmp(stepType, 'fr')
    % stance phase for leg 2 & leg 6
    y1 = linspace(-stepDistance(2)/4, stepDistance(2)/4,num/2);
    x1 = linspace(-stepDistance(1)/4, stepDistance(1)/4,num/2);
    z1 = stanceZ*ones(1,num/2);
    
    % flight phase for leg 2 & leg 6
    x2 = linspace(stepDistance(1)/4,-stepDistance(1)/4,num/2);
    y2 = linspace(stepDistance(2)/4,-stepDistance(2)/4,num/2);
    z2 = -stepHeight*(1.5/(norm(stepDistance))^2)*(((x2.^2+y2.^2)));

    % calculate x and z position differences inbetween phases to make the
    % trajectory continous
    diffX = x1(1)-x2(end);
    diffZ = z1(1)-z2(end);

    % adjust x and z values
    x2 = x2+diffX;
    z2 = z2+diffZ;
    
    x1 = x1+0.8*stanceX;
    x2 = x2+0.8*stanceX;
end

% % plot final trajectory
% plot3(x,y,z)
% title('Footstep Trajectory')
% xlabel('x [m]')
% ylabel('y [m]')
% zlabel('z [m]')
% axis([0 .35 -.1 .1 -.25 .15])
% view(44,16)
% grid on
end

