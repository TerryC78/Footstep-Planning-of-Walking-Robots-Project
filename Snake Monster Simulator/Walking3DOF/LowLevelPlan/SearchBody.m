function [BodyPath] = SearchBody(BodyCostMap, Direction, Config)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    % change body cost map into a sparse matrix
    [c1, c2] = size(BodyCostMap);
    
    TotalEdge = 4*(c1-2)*(c2-2) + 3*(c1+c2-4) + 2*4;
    x = zeros(TotalEdge,1);
    y = x;
    s = x;
    
    % NodeNum
    %  ----------------->y
    % |      1 2 3 ... c2
    % |   c2+1
    % | 2*c2+1 
    % |   .
    % |   .
    % |c1*c2+1
    % *
    % x
    cnt = 1; 
    
    for i = 1:c1 % row => x
        for j = 1:c2 % col => y
            NodeNum = c2*(i-1) + j;
            if i ~= 1 && i ~= c1 && j ~= 1 && j ~= c2 % 1) center
                
                x(cnt:cnt+3) = [NodeNum - c2, NodeNum - 1, NodeNum + 1, NodeNum + c2];
                y(cnt:cnt+3) = NodeNum * ones(4, 1);
                s(cnt:cnt+3, 1) = BodyCostMap(i, j) * ones(4, 1);
                cnt = cnt + 4;
            
            elseif i == 1 && j ~= c2 % on top edge
                if  j == 1 % top left corner
                    
                    x(cnt:cnt+1) = [NodeNum + 1, NodeNum + c2];
                    y(cnt:cnt+1) = NodeNum * ones(2, 1);
                    s(cnt:cnt+1, 1) = BodyCostMap(i, j) * ones(2, 1);
                    cnt = cnt + 2;
                else 
                    
                    x(cnt:cnt+2) = [NodeNum - 1, NodeNum + 1, NodeNum + c2];
                    y(cnt:cnt+2) = NodeNum * ones(3, 1);
                    s(cnt:cnt+2, 1) = BodyCostMap(i, j) * ones(3, 1);
                    cnt = cnt + 3;
                end
                    
            elseif j == c2 && i ~= c1 % on right edge
                if  i == 1 % top right corner
                    
                    x(cnt:cnt+1) = [NodeNum - 1, NodeNum + c2];
                    y(cnt:cnt+1) = NodeNum * ones(2, 1);
                    s(cnt:cnt+1, 1) = BodyCostMap(i, j) * ones(2, 1);
                    cnt = cnt + 2;
                else
                    
                    x(cnt:cnt+2) = [NodeNum - c2, NodeNum - 1, NodeNum + c2];
                    y(cnt:cnt+2) = NodeNum * ones(3, 1);
                    s(cnt:cnt+2, 1) = BodyCostMap(i, j) * ones(3, 1);
                    cnt = cnt + 3;
                    
                end
                
            elseif i == c1 && j ~= 1 % on bottom edge
                if  j == c2 % bottom right corner
                    
                    x(cnt:cnt+1) = [NodeNum - 1, NodeNum - c2];
                    y(cnt:cnt+1) = NodeNum * ones(2, 1);
                    s(cnt:cnt+1, 1) = BodyCostMap(i, j) * ones(2, 1);
                    cnt = cnt + 2;
                else
                   
                    x(cnt:cnt+2) = [NodeNum - c2, NodeNum - 1, NodeNum + 1];
                    y(cnt:cnt+2) = NodeNum * ones(3, 1);
                    s(cnt:cnt+2, 1) = BodyCostMap(i, j) * ones(3, 1);
                    cnt = cnt + 3;
                end
                
            elseif j == 1 && i ~= 1 % on left edge
                if  i == c1 % bottom left corner
                    
                    x(cnt:cnt+1) = [NodeNum + 1, NodeNum - c2];
                    y(cnt:cnt+1) = NodeNum * ones(2, 1);
                    s(cnt:cnt+1, 1) = BodyCostMap(i, j) * ones(2, 1);
                    cnt = cnt + 2;
                else
                   
                    x(cnt:cnt+2) = [NodeNum - c2, NodeNum + c2, NodeNum + 1];
                    y(cnt:cnt+2) = NodeNum * ones(3, 1);
                    s(cnt:cnt+2, 1) = BodyCostMap(i, j) * ones(3, 1);
                    cnt = cnt + 3;
                end
            end
        end
    end
    
    A = sparse(x, y, s, c1*c2, c1*c2);
    
    switch Direction
        case 1
            Srow = (1*2400/5/4) - Config.MarginY;
            Scol = (1*2400/5/4) - Config.MarginX;
            Erow = (3*2400/5/4) - Config.MarginY;
            Ecol = (3*2400/5/4) - Config.MarginX;
        case 2
            Srow = (1*2400/5/4) - Config.MarginY;
            Scol = (1*2400/5/4) - Config.MarginX;
            Erow = (3*2400/5/4) - Config.MarginY;
            Ecol = (1*2400/5/4) - Config.MarginX;
        case 3
            Srow = (1*2400/5/4) - Config.MarginY;
            Scol = (3*2400/5/4) - Config.MarginX;
            Erow = (3*2400/5/4) - Config.MarginY;
            Ecol = (1*2400/5/4) - Config.MarginX;
        case 4
            Srow = (1*2400/5/4) - Config.MarginY;
            Scol = (3*2400/5/4) - Config.MarginX;
            Erow = (1*2400/5/4) - Config.MarginY;
            Ecol = (1*2400/5/4) - Config.MarginX;
        case 5
            Srow = (3*2400/5/4) - Config.MarginY;
            Scol = (3*2400/5/4) - Config.MarginX;
            Erow = (1*2400/5/4) - Config.MarginY;
            Ecol = (1*2400/5/4) - Config.MarginX;
        case 6
            Srow = (3*2400/5/4) - Config.MarginY;
            Scol = (1*2400/5/4) - Config.MarginX;
            Erow = (1*2400/5/4) - Config.MarginY;
            Ecol = (1*2400/5/4) - Config.MarginX;
        case 7
            Srow = (3*2400/5/4) - Config.MarginY;
            Scol = (1*2400/5/4) - Config.MarginX;
            Erow = (1*2400/5/4) - Config.MarginY;
            Ecol = (3*2400/5/4) - Config.MarginX;
        case 8
            Srow = (1*2400/5/4) - Config.MarginY;
            Scol = (1*2400/5/4) - Config.MarginX;
            Erow = (1*2400/5/4) - Config.MarginY;
            Ecol = (3*2400/5/4) - Config.MarginX;
        case 9
            Srow = (1*2400/5/4) - Config.MarginY;
            Scol = (3*2400/5/4) - Config.MarginX;
            Erow = (3*2400/5/4) - Config.MarginY;
            Ecol = (3*2400/5/4) - Config.MarginX;
        case 10
            Srow = (3*2400/5/4) - Config.MarginY;
            Scol = (1*2400/5/4) - Config.MarginX;
            Erow = (3*2400/5/4) - Config.MarginY;
            Ecol = (3*2400/5/4) - Config.MarginX;
        case 11
            Srow = (3*2400/5/4) - Config.MarginY;
            Scol = (3*2400/5/4) - Config.MarginX;
            Erow = (1*2400/5/4) - Config.MarginY;
            Ecol = (3*2400/5/4) - Config.MarginX;
        case 12
            Srow = (3*2400/5/4) - Config.MarginY;
            Scol = (3*2400/5/4) - Config.MarginX;
            Erow = (3*2400/5/4) - Config.MarginY;
            Ecol = (1*2400/5/4) - Config.MarginX;
    end
    
    StartNode = c2*(Srow-1) + Scol;
    EndNode = c2*(Erow-1) + Ecol;
    
    % dij algorithm
    [d, pred] = dijkstra(A, StartNode);
    
    % reconstruct the path from pred
    tmp = EndNode;
    PathNum = [EndNode];
    while 1
        tmp = pred(tmp);
        PathNum = [PathNum; tmp];
        if tmp == StartNode
            break;
        end
    end
    n1 = length(PathNum);
    BodyNodeNum = PathNum(n1:-1:1);
    BodyPath = zeros(n1, 2);
    BodyPath(:, 2) = mod(BodyNodeNum-1, c2)+1;  % y
    BodyPath(:, 1) = floor((BodyNodeNum-1)/c2)+1;  % x
%     plot(BodyPath(:, 1), BodyPath(:, 2));

end

