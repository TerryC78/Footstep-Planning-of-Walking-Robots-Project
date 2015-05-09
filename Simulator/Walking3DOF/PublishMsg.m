function [leg] = PublishMsg(joint_angles)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

step_freq = 20;
num = 100;

for k = 1:6
    % Repeat angles for however many number of steps the simulation is
    % specified for            
%     for i = 1:(numStep)
%         hipM(:,i) = joint_angles(1,k,:);
%         kneeM(:,i) = joint_angles(2,k,:);
%         ankleM(:,i) = joint_angles(3,k,:);
%     end
%     hipM(:,1) = joint_angles(1,k,:);
%     kneeM(:,1) = joint_angles(2,k,:);
%     ankleM(:,1) = joint_angles(3,k,:);
    hipV = joint_angles(1,k,:);
    kneeV = joint_angles(2,k,:);
    ankleV = joint_angles(3,k,:);

    % merge all columns into 1 column
%     hipV = hipM(:);
%     kneeV = kneeM(:);
%     ankleV = ankleM(:);
    
    % Leg joint position control trajectory timeseries
    leg(k).hip.angles = timeseries(hipV);
    leg(k).knee.angles = timeseries(kneeV);
    leg(k).ankle.angles = timeseries(ankleV);
    leg(k).hip.angles.time = leg(k).hip.angles.time*(step_freq/num);
    leg(k).knee.angles.time = leg(k).knee.angles.time*(step_freq/num);
    leg(k).ankle.angles.time = leg(k).ankle.angles.time*(step_freq/num);

    % initial conditions
    leg(k).hip.IC = joint_angles(1,k,1);
    leg(k).knee.IC = joint_angles(2,k,1);
    leg(k).ankle.IC = joint_angles(3,k,1);
    
    fprintf('[Publish] %1.1f%% complete\n', 100*k/6);
end

%% Change Gait Type

% %turn left
% leg(2).hip.angles.Data = -leg(1).hip.angles.Data;
% leg(4).hip.angles.Data = -leg(3).hip.angles.Data;
% leg(6).hip.angles.Data = -leg(5).hip.angles.Data;

% %turn right
% leg(1).hip.angles.Data = -leg(2).hip.angles.Data;
% leg(3).hip.angles.Data = -leg(4).hip.angles.Data;
% leg(5).hip.angles.Data = -leg(6).hip.angles.Data;

% % skating??
% leg(2) = leg(1);
% leg(3) = leg(1);
% leg(4) = leg(1);
% leg(5) = leg(1);
% leg(6) = leg(1);

%  Manipulating legs Gaits
% leg(6) = leg(7);   %lift up one leg

% % quadruped walking
% leg(6) = leg(4);
% leg(5) = leg(3);
% leg(4) = leg(7);
% leg(3) = leg(7);

% % hind legs lifted up
% leg(1) = leg(7);
% leg(2) = leg(7);

end



