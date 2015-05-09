function [MoreFootStep] = ConnectStep(footstep, LowBodyPath, RelaPosition, Phase, num)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
    
    % flight phase z value
    x = [1 50 100];
    z = [1 .5 1];
    p = polyfit(x, z, 2);
    x1 = 1:100;
    z1 = polyval(p, x1);

    % classify phase
    if sum(sum(footstep(1:2,[1 4 5], 1) == footstep(1:2, [1 4 5], 2))) == 6
        Phase = 1;
    else
        Phase = 0; 
    end
    
    % change coordinate   
    if Phase == 0  % first set of feet => leg145
        % stance phase
        leg2x = linspace(-RelaPosition(2, 2, 1),-RelaPosition(2, 2, 2), num);
        leg2y = linspace(-RelaPosition(1, 2, 1),-RelaPosition(1, 2, 2), num); 
        leg2z = linspace( RelaPosition(3, 2, 1), RelaPosition(3, 2, 2), num);
        
        leg3x = linspace( RelaPosition(2, 3, 1), RelaPosition(2, 3, 2), num);
        leg3y = linspace( RelaPosition(1, 3, 1), RelaPosition(1, 3, 2), num); 
        leg3z = linspace( RelaPosition(3, 3, 1), RelaPosition(3, 3, 2), num);
        
        leg6x = linspace(-RelaPosition(2, 6, 1),-RelaPosition(2, 6, 2), num);
        leg6y = linspace(-RelaPosition(1, 6, 1),-RelaPosition(1, 6, 2), num); 
        leg6z = linspace( RelaPosition(3, 6, 1), RelaPosition(3, 6, 2), num);
        
        % flight phase || fit z by quadratic polynomials
        leg1x = linspace( RelaPosition(2, 1, 1), RelaPosition(2, 1, 2), num);
        leg1y = linspace( RelaPosition(1, 1, 1), RelaPosition(1, 1, 2), num); 
        leg1z = linspace( RelaPosition(3, 1, 1), RelaPosition(3, 1, 2), num) .* z1;
        
        leg4x = linspace(-RelaPosition(2, 4, 1),-RelaPosition(2, 4, 2), num);
        leg4y = linspace(-RelaPosition(1, 4, 1),-RelaPosition(1, 4, 2), num); 
        leg4z = linspace( RelaPosition(3, 4, 1), RelaPosition(3, 4, 2), num) .* z1;
        
        leg5x = linspace( RelaPosition(2, 5, 1), RelaPosition(2, 5, 2), num);
        leg5y = linspace( RelaPosition(1, 5, 1), RelaPosition(1, 5, 2), num); 
        leg5z = linspace( RelaPosition(3, 5, 1), RelaPosition(3, 5, 2), num) .* z1;
        

    elseif Phase == 1 % second set of feet => leg236
        % stance phase
        leg1x = linspace( RelaPosition(2, 1, 1), RelaPosition(2, 1, 2), num);
        leg1y = linspace( RelaPosition(1, 1, 1), RelaPosition(1, 1, 2), num); 
        leg1z = linspace( RelaPosition(3, 1, 1), RelaPosition(3, 1, 2), num);
        
        leg4x = linspace(-RelaPosition(2, 4, 1),-RelaPosition(2, 4, 2), num);
        leg4y = linspace(-RelaPosition(1, 4, 1),-RelaPosition(1, 4, 2), num); 
        leg4z = linspace( RelaPosition(3, 4, 1), RelaPosition(3, 4, 2), num);
        
        leg5x = linspace( RelaPosition(2, 5, 1), RelaPosition(2, 5, 2), num);
        leg5y = linspace( RelaPosition(1, 5, 1), RelaPosition(1, 5, 2), num); 
        leg5z = linspace( RelaPosition(3, 5, 1), RelaPosition(3, 5, 2), num);
        
        % flight phase
        leg2x = linspace(-RelaPosition(2, 2, 1),-RelaPosition(2, 2, 2), num);
        leg2y = linspace(-RelaPosition(1, 2, 1),-RelaPosition(1, 2, 2), num); 
        leg2z = linspace( RelaPosition(3, 2, 1), RelaPosition(3, 2, 2), num) .* z1;
        
        leg3x = linspace( RelaPosition(2, 3, 1), RelaPosition(2, 3, 2), num);
        leg3y = linspace( RelaPosition(1, 3, 1), RelaPosition(1, 3, 2), num); 
        leg3z = linspace( RelaPosition(3, 3, 1), RelaPosition(3, 3, 2), num) .* z1;
        
        leg6x = linspace(-RelaPosition(2, 6, 1),-RelaPosition(2, 6, 2), num);
        leg6y = linspace(-RelaPosition(1, 6, 1),-RelaPosition(1, 6, 2), num); 
        leg6z = linspace( RelaPosition(3, 6, 1), RelaPosition(3, 6, 2), num) .* z1;
        
    end
    
    MoreFootStep = zeros(3, 6, num);
    MoreFootStep(:, 1, :) = [leg1x; leg1y; leg1z];
    MoreFootStep(:, 2, :) = [leg2x; leg2y; leg2z];
    MoreFootStep(:, 3, :) = [leg3x; leg3y; leg3z];
    MoreFootStep(:, 4, :) = [leg4x; leg4y; leg4z];
    MoreFootStep(:, 5, :) = [leg5x; leg5y; leg5z];
    MoreFootStep(:, 6, :) = [leg6x; leg6y; leg6z];
    
end