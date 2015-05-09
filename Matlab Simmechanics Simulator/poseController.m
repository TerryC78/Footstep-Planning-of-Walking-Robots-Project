function [ jointAngles ] = poseController(poseDesired, config, poseNow)
% Snake Monster Walking
% BioRobotics Lab
% Author: Simon Kalouche
%
% Pose Estimation and Control
% INPUT:        poseDesired: [(pitch) rotation about x-axis, (roll) rotation
%                            about y-axis,(yaw) roation about z-axis]
%               poseNow: all joint angles for current position
%               hexXY: [hexX, hexY] hex configuration shape

% assign variable values from inputs
hexX = config.hexXY(1);
hexY = config.hexXY(2);
stanceH = config.stanceHeight;
stanceW = config.stanceWidth;
pitch = deg2rad(poseDesired(1));
roll = deg2rad(poseDesired(2));
yaw = deg2rad(poseDesired(3));


% Snake Monster Parameters
SM = SM_Params();
bodyW = 2*SM.body.size(1);
bodyL = 2*SM.body.size(2);
orient = SM.body.leg(:,1);
xc = SM.body.leg(:,2);
yc = SM.body.leg(:,3);

% Functions for Screw Rotation Matrices
Xdisp=@(pitch) [1 0 0; 0 cos(pitch) -sin(pitch); 0 sin(pitch) cos(pitch)];
Ydisp=@(roll) [cos(roll) 0 sin(roll); 0 1 0; -sin(roll) 0 cos(roll)];
Zdisp=@(orient,yaw) [cos(orient+yaw) -sin(orient+yaw) 0; sin(orient+yaw) cos(orient+yaw) 0; 0 0 1];

% initialize feet position based on config
FootXYZ(1:3,1) = [stanceW + hexX, hexY, stanceH]';
FootXYZ(1:3,2) = [stanceW + hexX, -hexY, stanceH]';
FootXYZ(1:3,3) = [stanceW, 0, stanceH]';
FootXYZ(1:3,4) = [stanceW, 0, stanceH]';
FootXYZ(1:3,5) = [stanceW + hexX, -hexY, stanceH]';
FootXYZ(1:3,6) = [stanceW + hexX, hexY, stanceH]';

% PITCH POSE: determine joint angles to get desired pitch pose
dyFeet = 2*hexY + bodyL;
dzFeet = dyFeet*tan(pitch);
FootXYZ(3,[1 2]) = FootXYZ(3,[1 2]) + dzFeet/2;
FootXYZ(3,[5 6]) = FootXYZ(3,[5 6]) - dzFeet/2;

% ROLL POSE: determine joint angles to get desired roll pose
dxFeet = 2*stanceW +bodyW;
dzFeet = dxFeet*tan(roll);
FootXYZ(3,[1 3 5]) = FootXYZ(3,[1 3 5]) + dzFeet/2;
FootXYZ(3,[2 4 6]) = FootXYZ(3,[2 4 6]) - dzFeet/2;

% YAW POSE: determine joint angles to get desired pitch pose
for i = 1:6
    dxyFeet(:,i) = Zdisp(orient(i),yaw)*[xc(i) yc(i) 1]' - Zdisp(orient(i),0)*[xc(i) yc(i) 1]';
    FootXYZ(1,i) = FootXYZ(1,i) + dxyFeet(1,i);
    FootXYZ(2,i) = FootXYZ(2,i) + dxyFeet(2,i);
end

if ~exist('poseNow')    
    % use IK to calculate joint angles for desired pose
    for i = 1:6
        jointAngles(1:3,i) = IK(FootXYZ(:,i));
    end
    
elseif exist('poseNow')
    % let
    num = 20;
    for i = 1:6
        % Get XYZ position of all feet using FK()
        NowFootXYZ(1:3,i) = FK(poseNow(:,i));
        
        % Create incremental motion to desired pose from initial pose
        dx(i,:) = linspace(NowFootXYZ(1,i),FootXYZ(1,i), num);
        dy(i,:) = linspace(NowFootXYZ(2,i),FootXYZ(2,i), num);
        dz(i,:) = linspace(NowFootXYZ(3,i),FootXYZ(3,i), num);
        
        for j = 1:num
            % use IK to calculate joint angles for desired pose
            jointAngles(1:3,i,j) = IK([dx(i,j), dy(i,j), dz(i,j)]);
        end
    end
     
end

end

