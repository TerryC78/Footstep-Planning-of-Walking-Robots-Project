function [SMparams] = SM_Params()
% This function is called when the parameters of Snake Monsters geometry
% are needed. This function serves to eliminate redundant entries of snake
% monster params
% OUTPUTS: l = [lo l1 l2 l3a l3b] -> link lengths
%          n_joints = number of joints or DOF
%          DH = [alpha; a;a] -> 3x3 matrix where 1st row is alpha, 2nd row
%          is a and 3rd row is d
%          G = base frame
%          H = tool frame
% 
% Simon Kalouche
% BioRobotics Lab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is used in: FK.m, IK.m, IKsym.m, SM_Pose.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % define Snake Monster Chassis Parameters
    xc = .075; %[m]
    yc = .1; %[m]
    zc = .16;   %[m]
    SMparams.body.leg(1,:) = [0, xc, yc, zc];
    SMparams.body.leg(2,:) = [pi, -xc, yc, zc];
    SMparams.body.leg(3,:) = [0, xc, 0, zc];
    SMparams.body.leg(4,:) = [pi, -xc, 0, zc];
    SMparams.body.leg(5,:) = [0, xc, -yc, zc];
    SMparams.body.leg(6,:) = [pi, -xc, -yc, zc];
    SMparams.body.mass = 6;     %[kg] body/chassis mass
    
    %body inertia (l-y, w-x, h-z)
    w = 2*xc;
    l = 2*yc;
    h = zc;
    Ixx = (1/12)*SMparams.body.mass*(h^2+l^2);
    Iyy = (1/12)*SMparams.body.mass*(w^2+h^2);
    Izz = (1/12)*SMparams.body.mass*(w^2+l^2);
    SMparams.body.inertia = [Ixx 0 0;0 Iyy 0; 0 0 Izz];
    
    % define Snake Monster limb parameters (3DOF)
    l0 = 0.04155; %[m] rigidly connected to SM chassis
    l1 = 0.0639; %[m]
    l2 = 0.127; %[m]
    l3a = 0.075; %[m]
    l3b = 0.186; %[m] rigidly connected to link 3 at 90 deg angle
    l=[l0 l1 l2 l3a l3b];
    n_joints = 3; % number of joints/DOF
    SMparams.leg.lengths = l;
    SMparams.leg.joints = n_joints;
    SMparams.leg.mass = [.5 .6 .7]; %[kg] link 0=link 1, link 2, link 3
    
    %link inertia's
    I_l1 = (1/12)*SMparams.leg.mass(1)*l1^2;    %Ixx=0, Iyy=Izz=(1/12)*m*l^2
    I_l2 = (1/12)*SMparams.leg.mass(2)*l2^2;
    I_l3 = (1/12)*SMparams.leg.mass(3)*(l3a^2+l3b^2);
    SMparams.leg.inertia(:,:,1) = [0 0 0; 0 I_l1 0; 0 0 I_l1];
    SMparams.leg.inertia(:,:,2) = [0 0 0; 0 I_l2 0; 0 0 I_l2];
    SMparams.leg.inertia(:,:,3) = [0 0 0; 0 I_l3 0; 0 0 I_l3];
    
    
    % D-H Parameters 
    alpha = [0 90 0]*pi/180;    %alpha(2) is positive (90) to match sign convention of CCW +
    a = [0 l1 l2];
    d = [0 0 0];
    DH=[alpha;a;d];
    SMparams.leg.DH = DH;
    
    % Base Frame [G]
    G = eye(4);
    G(:,4)=[l0 0 0 1];
    SMparams.leg.BaseFrame = G;
    
    % Tool Frame [H]
    H = eye(4);
    H(:,4)=[l3a -l3b 0 1];      %l3b made negative to match sign convention of CCW +
    SMparams.leg.ToolFrame = H;


end

