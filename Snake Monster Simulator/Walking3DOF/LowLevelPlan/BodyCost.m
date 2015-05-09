function [BodyCostMap] = BodyCost(CostMap, Config)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    MarginX = Config.MarginX; % margin of the cost map
    MarginY = Config.MarginY; 
    
    Radius = Config.Radius;  % search radius for every foot
    OffsetX1 = Config.OffsetX1;
    OffsetX2 = Config.OffsetX2;
    OffsetY1 = Config.OffsetY1;
    OffsetY2 = Config.OffsetY2;
    
    [c1, c2] = size(CostMap);
    BodyCostMap = zeros(c1-2*MarginY, c2-2*MarginX);
    
    RankNum = 5;
    for i = 1:(c1-2*MarginY) % row => x
        for j = 1:(c2-2*MarginX) % col => y
            x = i + MarginY;  % row
            y = j + MarginX;  % col
            Cost = zeros(RankNum, 6); % 6 legs with 5 best optimal footholds
            [~,  Cost(:, 1)] = SearchCost(CostMap, y+OffsetX1, x+OffsetY1, y+OffsetX2, x+OffsetY2, RankNum); % leg 1
            [~,  Cost(:, 2)] = SearchCost(CostMap, y-OffsetX2, x+OffsetY1, y-OffsetX1, x+OffsetY2, RankNum); % leg 2
            [~,  Cost(:, 3)] = SearchCost(CostMap, y+OffsetX1, x-Radius  , y+OffsetX2, x+Radius  , RankNum); % leg 3
            [~,  Cost(:, 4)] = SearchCost(CostMap, y-OffsetX2, x-Radius  , y-OffsetX1, x+Radius  , RankNum); % leg 4
            [~,  Cost(:, 5)] = SearchCost(CostMap, y+OffsetX1, x-OffsetY2, y+OffsetX2, x-OffsetY1, RankNum); % leg 5
            [~,  Cost(:, 6)] = SearchCost(CostMap, y-OffsetX2, x-OffsetY2, y-OffsetX1, x-OffsetY1, RankNum); % leg 6
            
            BodyCostMap(i, j) = sum(Cost(:))/RankNum; % find average
        end
    end

end

