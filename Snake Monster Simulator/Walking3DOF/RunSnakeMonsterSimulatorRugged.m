% un this script to load all the simulation parameters into the workspace
%
% Author: Simon Kalouche
% BioRobotics Lab


% In Windows
% repmat([]), 2 places
% ground contact model: xy order, breakpoints
% patch high level planning
clc
close all
clear all

%% 1) Hexapod Parameters
% input SM params
SMparams = SM_Params();
l = SMparams.leg.lengths;
m = SMparams.leg.mass;   
m_body = SMparams.body.mass;        %[kg] body mass
i_body = SMparams.body.inertia;     %[kg-m^2] body inertia

% link lengths [m] 
l0=l(1); l1=l(2); l2=l(3); l3a=l(4);l3b=l(5);

% link masses [kg]
m1=m(1); m2=m(2); m3=m(3);

%link inertias [kg-m^2]
il1 = SMparams.leg.inertia(:,:,1);
il2 = SMparams.leg.inertia(:,:,2);
il3 = SMparams.leg.inertia(:,:,3);

%leg locations on torso relative to COM
xc = SMparams.body.leg(1,2);            %[m]
yc = SMparams.body.leg(1,3);            %[m]
zc = SMparams.body.leg(1,4);            %[m]

% Right leg link lengths
RL0 = [l0 0 0];
RL1 = [l1 0 0];
RL2 = [l2 0 0];
RL3 = [l3a 0 -l3b];

% Left leg link lengths
LL0 = [-l0 0 0];
LL1 = [-l1 0 0];
LL2 = [-l2 0 0];
LL3 = [-l3a 0 -l3b];

% actuator parameters
Tmax = 70;      %[N/m] 12

%PD control gains for joints 1,2,3
%P kains
kp1 = 150;  kp2 = 150; kp3 = 150;
%D gains
kd1 = 150; kd2 = 150; kd3 = 150;        

%% 2) World Parameters

% Ground Surface World Size
global Worldx
global Worldy
Worldx = 10;        %[m]
Worldy = 10;        %[m]

% Terrain
% load('terrain');
% dist2 = terrain;
terrain = ReadTerrain('EasyTest.png', 0);

% terrain = 5 .* terrain;
[terrainX, terrainY] = size(terrain);

% % Ground slope 
% zGround = .4;   %0.4
% GroundIncline = rad2deg(atan(zGround/1));

% Rugged Terrain:  zGround(1000*round(u(1)), 1000*round(u(2)))
amp = .02;       % [m] max amplitude or height of terrain
freqT = 6;       % frequency of oscillations in ground terrain
res = 10;
% load WorldData4SM.mat
% for x = 10:res:Worldx*1000
%     for y = 10:res:Worldy*1000
%         
%         % calculate ground height
%         zGround(x,y) = amp*sin(freqT*x)+amp*cos(freqT*y);
%         
%         % set color for plotting
%         if (zGround(x,y) > 0)
%             color = (zGround(x,y)/max(zGround(:)))*[1 1 1];
%         else
%             color = (abs(zGround(x,y))/max(zGround(:)))*[0 1 1];
%         end
%         
%         figure(1);
%         plot3(x/1000,y/1000,zGround(x,y),'.','Color',color,'MarkerSize',10);
%         hold on
%         grid on
%         axis equal
%         %drawnow     
%     end  
% end


%% 3) Ground Interaction Model 

%--------------------------------------------------------
% Vertical component
m = 2; %[kg]
g = 9.81; %[kg]

% stiffness of vertical ground interaction
k_gn = m*g/0.001; %[N/m]

% max relaxation speed of vertical ground interaction
v_gn_max = 0.03; %[m/s]

%--------------------------------------------------------

%--------------------------------------------------------
% Horizontal component
% sliding friction coefficient
mu_slide = 0.85; %original: .8

% sliding to stiction transition velocity limit
vLimit = 0.01; %[m/s] original: .01

% stiffness of horizontal ground stiction
k_gt = m*g/0.001; %[N/m] original: m*g/0.1

% max relaxation speed of horizontal ground stiction
v_gt_max = 0.03; %[m/s] original: 0.03

% stiction to sliding transition coefficient
mu_stick = 0.9; %original: .9
%--------------------------------------------------------


%% 4) Generate Foot Trajectory
% -------------------- Learning the terrain --------------------------- %
% CostMapHigh: 10 by 10
% CostMap: whole terrain map
TerrainFile = 'EasyTest.png';
HighOptions.ShowTerrain = 0;
HighOptions.Train = 0;
HighOptions.Test = 0;
HighOptions.ClassifyTerrain = 1;
HighOptions.Resolution = [100; 100];
HighOptions.LearnRegion = [6; 6; 95; 95];

[CostMapHigh, ~] = Train_cost_func(TerrainFile, HighOptions); % 100 by 100 matrix
% save('CostMapDebug.mat','CostMap');
% load('CostMapDebug.mat');

% ---------------------- High Level Planning -------------------------- %
fprintf('[High Level Plan] Planning...\n')
rob_path = HighLevelPlan(CostMapHigh); % High level planning

% ---------------------- Low  Level Planning -------------------------- %
fprintf('[Low Level Plan] Planning...\n')
[c1, ~] = size(rob_path);  % need c1-1 times low level planning

ResX = 2400;
ResY = ResX;
MovePath = diff(rob_path);  % c1-1 by 2 matrix
LowOptions.ShowTerrain = 0;
LowOptions.Train = 0;
LowOptions.Test = 0;
LowOptions.ClassifyTerrain = 1;
LowOptions.Resolution = [ResX; ResY];

TotalFootStep = zeros(3, 6, 1);
TotalBodyPath = zeros(3, 1);

i = 1;
while i < c1  % c1 times low level planning
    
    fprintf('-----------%d/%d step-----------\n', i, c1-1);
    %_3_|_2_|_1_
    %_4_|_*_|_8_
    % 5 | 6 | 7
    % right go up 9 down 11
    % up go right 10 left 12
    LowOptions.Direction = MoveDirection(MovePath(i, :), rob_path(i,:));
    CurX = rob_path(i, 1);
    CurY = rob_path(i, 2);
    
    % find low level search area
    d_move = round(2400/5)-11;
    switch LowOptions.Direction
        case {1, 2, 8} 
            MoveX = d_move;
            MoveY = d_move;
            x1 = round((CurX-1)*(ResX/10)+1)+5;
            y1 = round((CurY-1)*(ResY/10)+1)+5;      
        case {3, 4, 9}
            MoveX = d_move;
            MoveY =-d_move;
            x1 = round((CurX-1)*(ResX/10)+1)+5;
            y1 = round((CurY  )*(ResY/10)+1)-6;
        case {5, 11, 12}
            MoveX =-d_move;
            MoveY =-d_move;
            x1 = round((CurX  )*(ResX/10)+1)-6;
            y1 = round((CurY  )*(ResY/10)+1)-6;
        case {6, 7, 10}
            MoveX =-d_move;
            MoveY = d_move;
            x1 = round((CurX  )*(ResX/10)+1)-6;
            y1 = round((CurY-1)*(ResY/10)+1)+5;
    end
    x2 = x1 + MoveX;
    y2 = y1 + MoveY;
    [x1, y1, x2, y2] = Reorder(x1, y1, x2, y2);
    LowOptions.LearnRegion = [x1; y1; x2; y2];
    
    [~, CostMap, LearnTerrain] = Train_cost_func(TerrainFile, LowOptions); 
    
    [ footstep, bodypath ] = LowLevelPlan(CostMap, LearnTerrain, LowOptions); % Low level planning 
    
    [~, ~, f3] = size(footstep);
    [~, b2] = size(bodypath);
    
    % insert difference
    if i > 1
        insertfoot = zeros(3, 6);
        insertfoot(:, [1 4 5]) = footstep(:, [1 4 5], 1);
        insertfoot(:, [2 3 6]) = TotalFootStep(:, [2 3 6], end);
        TotalFootStep(:,:,end+1) = insertfoot;
        insertbody = (bodypath(:, 1) + TotalBodyPath(:, end))/2;
        TotalBodyPath(:,end+1) = insertbody;
    end
        
    TotalFootStep(:, :, end+1:end+f3) = footstep;
    TotalBodyPath(:, end+1:end+b2) = bodypath;
    
    i = i + 1;
    
end

save('TotalBodyPath.mat', 'TotalBodyPath');
save('TotalFootStep.mat', 'TotalFootStep');

% load('TotalBodyPath.mat');
% load('TotalFootStep.mat');

% plot total footstep
[~,~,f3] = size(TotalFootStep);
figure(10)
x = reshape(TotalFootStep(2,1,:), f3, 1);
y = reshape(TotalFootStep(1,1,:), f3, 1);
plot(x(2:end), y(2:end), 'r')
hold on
x = reshape(TotalFootStep(2,2,:), f3, 1);
y = reshape(TotalFootStep(1,2,:), f3, 1);
plot(x(2:end), y(2:end), 'b')
hold on
x = reshape(TotalFootStep(2,3,:), f3, 1);
y = reshape(TotalFootStep(1,3,:), f3, 1);
plot(x(2:end), y(2:end), 'y')
hold on
x = reshape(TotalFootStep(2,4,:), f3, 1);
y = reshape(TotalFootStep(1,4,:), f3, 1);
plot(x(2:end), y(2:end), 'g')
hold on
x = reshape(TotalFootStep(2,5,:), f3, 1);
y = reshape(TotalFootStep(1,5,:), f3, 1);
plot(x(2:end), y(2:end), 'm')
hold on
x = reshape(TotalFootStep(2,6,:), f3, 1);
y = reshape(TotalFootStep(1,6,:), f3, 1);
plot(x(2:end), y(2:end), 'k')
hold on
legend('leg1','leg2','leg3','leg4','leg5','leg6','Location','NorthWest');
title('Footstep path for 6 legs')
xlabel('y direction')
ylabel('x direction')
axis([0 10 0 10])
grid on

% plot total bodypath
figure(11)
plot(TotalBodyPath(2,2:end),TotalBodyPath(1,2:end), 'k', 'LineWidth', 2)
legend('Final Body Path','Location','NorthWest')
title('Final Body Path from low level planner')
xlabel('y direction')
ylabel('x direction')
axis([0 10 0 10])
grid on

% ------------------- Generate joint angle Traj ----------------------- %
fprintf('[Trajectroy] Generating Traj...\n')
[joint_angles, RelaPosition] = GenerateTraj(TotalFootStep, TotalBodyPath);
% remove imag numbers
idx = find(imag(joint_angles)~=0);
joint_angles(:,:,(floor((idx-1)/18)+1)) = [];

% ------------------- publish msg to the robot ------------------------ %
fprintf('[Publish] Publishing to the robot...\n')
[leg] = PublishMsg(joint_angles(:,:,2:end));

% ----------------------- RUN SIMULATOR ------------------------------- %
fprintf('[Simulation] Running Simulation...\n')
sim('hexapod_bodyrugged.slx')


