function [ f ] = fvalue(x, y, a, b, c, sgn)
%   fvalue: returns the terrain template
%   change a, b, c
    % x: -0.05:0.01:0.05    eleven points
    % y: -0.05:0.01:0.05    eleven points
    % z: [-0.05, 0.05]
    % (x/a)^2 + (y/b)^2 + (z/c)^2 = 1
    if 1 - (x/a)^2 - (y/b)^2 <=0    % if (x, y) is not in the domain of f
        f = 0;  % then return 0
    else 
        if sgn == 1    % take positive value of f
            f = sqrt(1 - (x/a)^2 - (y/b)^2)*c; % else return fvalue
        end
        if sgn == 0     % take negative value of f
            f = -sqrt(1 - (x/a)^2 - (y/b)^2)*c;
        end
    end

end

