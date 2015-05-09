function [ joint_angles, RelaPosition ] = GenerateTraj(footstep, LowBodyPath)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    
    num = 100;
    [~, ~, f3] = size(footstep);
    [~, l2] = size(LowBodyPath);
    
    tmp = repmat(LowBodyPath, 6, 1);
    BodyPathExpand = reshape(tmp, 3, 6, l2);
    
    % body path to base path
    xc = 0.075;
    yc = 0.1;  % defined in SM_param()
    zc = 0;
    
    OffsetMat =  repmat([yc  yc   0   0 -yc -yc; ...
                         xc -xc  xc -xc  xc -xc; ...
                         zc  zc  zc  zc  zc  zc], 1, 1, f3);
                     
    RelaPosition = footstep - BodyPathExpand - OffsetMat;  % the position of the footsteps
                                                           % with respect to body
                                                           % center
    joint_angles = zeros(3, 6, 1);
    
    for i = 2:f3-1 % f3 - 1 intervals between every two footsteps
        % 1) first discrete the footstep by num points
        %  for 6 legs individually, 3(xyz) by 6(6 legs) by num pages
        % classify stance phase or flight phase
        [MoreFootStep] = ConnectStep(footstep(:, :, i:i+1), ...
                                     LowBodyPath(:, i:i+1), ...
                                     RelaPosition(:, :, i:i+1), ...
                                     mod(i, 2), num);  % mod(i, 2) 1 => leg145; 0=>leg236
        
        % 2) solve IK for the given footsteps
        JointAngles = SolveIK(MoreFootStep);
    
        % 3) store it into joint_angles
        joint_angles(:, :, end+1:end+num) = JointAngles;
        
    end
    
%     
%     [c1, c2] = size(rob_path);
% 
%     % generate high level path
%     numStep = 5; %number of steps to take
%     step_freq = 20;  %[s] time for leg to move thru trajectory for 1 step
%     num = 100; % number of increments per step; must be a number divisible by 4
%     joint_angles = zeros(3, 6, num*numStep*c1);
%     % joint_angles = zeros(3, 6, num);
%     
%     for i = 1:c1  % c1 path transitions
%          joint_angle = GenerateFootTraj(rob_path(i,1), rob_path(i,2), numStep, step_freq, num);
%     % for i = 1:1
%     %     joint_angle = GenerateFootTraj(-0.2, 0, numStep, step_freq, num);
%         for j = 1:numStep  % repeat footstep
%             joint_angles(:, :, (((i-1)*numStep+(j-1))*num+1):((i-1)*numStep+(j))*num) = joint_angle;
%         end
%     end

% for j = 1:num
%     % for limb(s) that are manipulating things
%     joint_angles(:,7,j) = IK([x3(j), y3(j), z3(j)]); 
% end


end

