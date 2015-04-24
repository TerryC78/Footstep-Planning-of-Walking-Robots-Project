function [RetPoints, RetCosts] = SearchCost(CostMap, y1, x1, y2, x2, Rank)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    Len = abs(x2 - x1)+1;
    Wid = abs(y2 - y1)+1;
    
%     fprintf('%d %d %d %d\n', y1, x1, y2, x2);
    SearchRegion = CostMap(y1:y2, x1:x2);
    [Order, Idx] = sort(SearchRegion(:));  % ascending order
    RetCosts = Order(1:Rank, 1);
    RetPoints = zeros(Rank, 2);
    for i = 1:Rank
        RetPoints(i, :) = [y1+floor((Idx(i)-1)/Len), x1+mod(Idx(i)-1, Len)];
    end
    
end

