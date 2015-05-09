function [RetPoints, RetCosts] = SearchCost(CostMap, y1, x1, y2, x2, Rank)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   SearchCost is in global coordinates
%   y1, x1, y2, x2 here are local coordinates
%   CostMap is in global Coordinates
    Len = abs(x2 - x1)+1;
    Wid = abs(y2 - y1)+1;
    
    [y1, x1, y2, x2] = Reorder(y1, x1, y2, x2);
%     fprintf('%d %d %d %d\n', y1, x1, y2, x2);
    SearchRegion = CostMap(y1:y2, x1:x2);
    
    [Order, Idx] = sort(SearchRegion(:));  % ascending order
    
    if Rank ~= 1
        RetCosts = Order(1:Rank, 1);
        RetPoints = zeros(Rank, 2);
        for i = 1:Rank
            RetPoints(i, :) = [y1+mod(Idx(i)-1, Len), x1+floor((Idx(i)-1)/Len)];
        end
    else
        RetCosts = Order(1:Rank, 1);
        % search for all candidates with the same lowest cost
        Candidates = Idx(find(Order == RetCosts));
        row = size(Candidates, 1);
        
        % search for the best point in the center
        Coordinate = [mod(Candidates-1, Len)+1, floor((Candidates - 1)/Len)+1];
        AbsDis = sum(abs(Coordinate - repmat([Len/2, Wid/2], row, 1)), 2);
        [Order2, Idx2] = sort(AbsDis);
        
        RetPoints = [Coordinate(Idx2(1),1)+y1-1, Coordinate(Idx2(1),2)+x1-1];
        
    end
    
end

