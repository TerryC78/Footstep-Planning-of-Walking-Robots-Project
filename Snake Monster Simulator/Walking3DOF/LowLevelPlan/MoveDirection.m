function [direction] = MoveDirection(Move, Path)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    %_3_|_2_|_1_
    %_4_|_*_|_8_
    % 5 | 6 | 7
    if Move(1) == 1 && Move(2) == 1
        direction = 1;
        fprintf('Going right forward!\n');
    elseif Move(1) == 1 && Move(2) == 0
        if Path(2) == 10
            direction = 9;
        else
            direction = 2;
        end
        fprintf('Going forward!\n');
    elseif Move(1) == 1 && Move(2) == -1
        direction = 3;
        fprintf('Going left forward!\n');
    elseif Move(1) == 0 && Move(2) == -1
        if Path(1) == 10
            direction = 12;
        else
            direction = 4;
        end
        fprintf('Going left!\n');
    elseif Move(1) == -1 && Move(2) == -1
        direction = 5;
        fprintf('Going left backward!\n');
    elseif Move(1) == -1 && Move(2) == 0
        if Path(2) == 10
            direction = 11;
        else
            direction = 6;
        end
        fprintf('Going backward!\n');
    elseif Move(1) == -1 && Move(2) == 1
        direction = 7;
        fprintf('Going right backward!\n');
    elseif Move(1) == 0 && Move(2) == 1
        if Path(1) == 10
            direction = 10;
        else
            direction = 8;
        end
        fprintf('Going right!\n');
    end

end

