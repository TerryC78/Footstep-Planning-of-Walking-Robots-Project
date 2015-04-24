function [Footstep, NewBodyPath] = GenerateFootstep(BodyPath, CostMap, Terrain, Config)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [StepNum, ~] = size(BodyPath);
    [c1, c2] = size(CostMap);
    [t1, t2] = Terrain;
    % FootStep has StepNum pages, in every page
    %    leg1  2  3  4  5  6
    % x
    % y
    % z
    Footstep = zeros(3, 6, StepNum);  % init
    
    % Configuration Parameters
    MarginX = Config.MarginX; % margin of the cost map
    MarginY = Config.MarginY; 
    
    FootX1 = Config.FootX1;
    FootX2 = Config.FootX2;
    FootY1 = Config.FootY1;
    FootY2 = Config.FootY2;
    FootY3 = Config.FootY3;
    FootY4 = Config.FootY4;
    
    %% starting position for 6 feet
    i = 1; % number of steps
    RankNum = 1;
    TotalCost = 0;
    Cost = zeros(RankNum, 6); % 6 legs with 5 best optimal footholds
    StepXYZ = zeros(6, 3);
    
    x = BodyPath(i, 1) + MarginY;
    y = BodyPath(i, 2) + MarginX;
   
    [StepXYZ(1, 1:2),  Cost(:, 1)] = SearchCost(CostMap, y+FootX1, x+FootY1, y+FootX2, x+FootY2, RankNum); % leg 1
    [StepXYZ(2, 1:2),  Cost(:, 2)] = SearchCost(CostMap, y-FootX2, x+FootY1, y-FootX1, x+FootY2, RankNum); % leg 2
    [StepXYZ(3, 1:2),  Cost(:, 3)] = SearchCost(CostMap, y+FootX1, x-FootY4, y+FootX2, x+FootY4, RankNum); % leg 3
    [StepXYZ(4, 1:2),  Cost(:, 4)] = SearchCost(CostMap, y-FootX2, x-FootY4, y-FootX1, x+FootY4, RankNum); % leg 4
    [StepXYZ(5, 1:2),  Cost(:, 5)] = SearchCost(CostMap, y+FootX1, x-FootY2, y+FootX2, x-FootY1, RankNum); % leg 5
    [StepXYZ(6, 1:2),  Cost(:, 6)] = SearchCost(CostMap, y-FootX2, x-FootY2, y-FootX1, x-FootY1, RankNum); % leg 6
    
    % look for height z value
    StepXYZ(:, 3) = interp2(linspace(1, c2, t2), linspace(1, c1, t1), Terrain, StepXYZ(:, 1), StepXYZ(:, 2));
    Footstep(:, :, 1) = StepXYZ';
    TotalCost = TotalCost + sum(Cost, 2);
    Oldx = x;
    Oldy = y;
    
    i = i + 1;
    
    %% plan for more steps
    while i <= StepNum
        
        Cost = zeros(RankNum, 6); % 6 legs with 5 best optimal footholds
            
        x = BodyPath(i, 1) + MarginY;
        y = BodyPath(i, 2) + MarginX;
        
        if mod(i, 2) == 0 % first group of feet moving, leg1 leg4 leg5
            
            % search for the next group of footsteps
            [StepXYZ(1, 1:2),  Cost(:, 1)] = SearchCost(CostMap, y+FootX1, x+FootY1, Oldy+FootX2, Oldx+FootY2, RankNum); % leg 1
            [StepXYZ(4, 1:2),  Cost(:, 4)] = SearchCost(CostMap, y-FootX2, x-FootY4, Oldy-FootX1, Oldx+FootY4, RankNum); % leg 4
            [StepXYZ(5, 1:2),  Cost(:, 5)] = SearchCost(CostMap, y+FootX1, x-FootY2, Oldy+FootX2, Oldx-FootY1, RankNum); % leg 5
                      
        else % second group of feet moving, leg2 leg3 leg6

            % search for the next group of footsteps
            [StepXYZ(2, 1:2),  Cost(:, 2)] = SearchCost(CostMap, y-FootX2, x+FootY1, Oldy-FootX1, Oldx+FootY2, RankNum); % leg 2
            [StepXYZ(3, 1:2),  Cost(:, 3)] = SearchCost(CostMap, y+FootX1, x-FootY4, Oldy+FootX2, Oldx+FootY4, RankNum); % leg 3
            [StepXYZ(6, 1:2),  Cost(:, 6)] = SearchCost(CostMap, y-FootX2, x-FootY2, Oldy-FootX1, Oldx-FootY1, RankNum); % leg 6
          
        end
        
        % look for height z value
        StepXYZ(:, 3) = interp2(linspace(1, c2, t2), linspace(1, c1, t1), Terrain, StepXYZ(:, 1), StepXYZ(:, 2));
        Footstep(:, :, i) = StepXYZ';
        TotalCost = TotalCost + sum(Cost, 2);
        
        Oldx = x;
        Oldy = y;

%         fprintf('[Low Level Plan] FootStep planning: %1.1f%% complete\n', 100*i/StepNum);
        
        i = i + 1;
        
    end
    
    %% New Body Path
    % finally, add z term to bodypath and modify format
    NewBodyPath = zeros(3, StepNum);
    NewBodyPath(1:2, :) = BodyPath';
    NewBodyPath(:, 3) = interp2(linspace(1, c2, t2), linspace(1, c1, t1), Terrain, NewBodyPath(:, 1), NewBodyPath(:, 2));

end

