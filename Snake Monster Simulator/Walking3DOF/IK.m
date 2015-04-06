function [theta] = IK(T,T1,T2,T3)
% Inverse Kinematics Geometry based solver for Snake Monster Limbs. 
% Given the x,y,z coordinate of the end effector the function will compute 
% the inverse kinematics of limb. The function geometrically solves for 
% the joint angle solutions and outputs all real solutions for the 3 joint
% angles: th1, th2, th3
%
% INPUTS:  T - 1 x 3 vector with x,y,z coordinate of end-effector or foot
%               position [m] (this is the only necessary INPUT)
%          T1 - 1 x 3 vector with x,y,z coordinate of hip1 [m]
%          T2 - 1 x 3 vector with x,y,z coordinate of hip2 [m]
% OUTPUTS:  th1 - angle of joint 1 (hip1) [deg]
%           th2 - angle of joint 2 (hip2) [deg]
%           th3 - angle of joint 3 (knee) [deg]
% 
% Simon Kalouche

% check if all input arguments are declared
if nargin<2
    T1=0;
    T2=0;
    T3=0;
end

%% input SM params
SMparams = SM_Params();
G = SMparams.leg.BaseFrame;
H = SMparams.leg.ToolFrame;
DH = SMparams.leg.DH;
l = SMparams.leg.lengths;
n_joints = SMparams.leg.joints;

% define input variables
l0=l(1); l1=l(2); l2=l(3); l3a=l(4);l3b=l(5);
alpha=DH(1,:); a=DH(2,:); d=DH(3,:);

%% Solve Inverse Kinematics with Geometry
x = T(1)-l0;    %subtract fixed length before hip joint axis
y = T(2);
z = T(3);

%theta 1 solution with arctan(y,x)
theta(1) = atan2(y,x);

l3 = sqrt(l3a^2+l3b^2);
Lt = sqrt(x^2+y^2)-l1;
L = sqrt(z^2 + Lt^2);
alpha1 = acos(z/L);
alpha2 = acos((L^2+l2^2-l3^2)/(-2*L*l2));
alpha = alpha1 + alpha2;

%theta 2 solution 
theta(2) = -(alpha - 3*pi/2);  %negative of angle used b/c traditional sign convention has CCW as +

beta = acos((l3^2+l2^2-L^2)/(2*l3*l2));

%theta 3 solution
theta(3) = -(pi - beta - atan2(l3b,l3a)); %negative of angle used b/c traditional sign convention has CCW as +

theta = theta*180/pi;

end
