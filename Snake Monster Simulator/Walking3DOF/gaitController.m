function [ jointAngles ] = gaitController(trajectory, hexXY, direction, num)
% Gait Controller for forward, backward, left, and right walking steps
%
% Simon Kalouche
% Biorobotics Lab

% extract info from input paramters and assign to appropriate variables
x1 = trajectory(1,:);
x2 = trajectory(2,:);
y1 = trajectory(3,:);
y2 = trajectory(4,:);
z1 = trajectory(5,:);
z2 = trajectory(6,:);
hexX = hexXY(1);
hexY = hexXY(2);

for j = 1:num
      if (strcmp(direction, 'fr')) % x1+ x2- ; y1+ y2- ; z1--ground z2--flight
     	  xa =  [x1,x2];           xb =  [x2,x1]; % xa  0.18 -> 0.28
 	      ya =  [y1,y2];           yb =  [y2,y1]; % ya -0.05 -> 0.05 
          za =  [z1,z2];           zb =  [z2,z1]; %  
% forward walking        
%         xa =  [x1,x2];           xb =  [x2,x1];
%         ya =  -[y1,y2];          yb =  [y2,y1];
%         za =  [z1,z2];           zb =  [z2,z1];

        % sidewalk: right
%         xa = [x1,x2];           xb = [x2,x1];
%         ya = [y1,y2];           yb = [y2,y1];
%         za = [z2,z1];           zb = [z1,z2];
        % use IK to calculate joint angles for given trajectory
        % For tripod gait
        jointAngles(1:3,1,j) = IK([xb(j)+hexX, yb(j)+hexY, za(j)]);
        jointAngles(1:3,4,j) = IK([xa(j), ya(j), za(j)]);
        jointAngles(1:3,5,j) = IK([xb(j)+hexX, yb(j)-hexY, za(j)]);

        jointAngles(1:3,2,j) = IK([xb(j)+hexX, yb(j)-hexY, zb(j)]);
        jointAngles(1:3,3,j) = IK([xa(j), ya(j), zb(j)]);
        jointAngles(1:3,6,j) = IK([xb(j)+hexX, yb(j)+hexY, zb(j)]);
      
      elseif (direction == 'f' || direction == 'b')
     % pair b flight phase first
        % total trajectory
%         xa = [x1,x2];           xb = [x2,x1];
%         ya = [y1,y2];           yb = [y2,y1];
%         za = [z2,z1];           zb = [z1,z2];
        xa =  [x1,x2];           xb =  [x2,x1];
        ya =  -[y1,y2];          yb =  [y2,y1];
        za =  [z1,z2];           zb =  [z2,z1];

        % use IK to calculate joint angles for given trajectory
        % For tripod gait
        jointAngles(1:3,1,j) = IK([xa(j)+hexX, ya(j)+hexY, za(j)]);
        jointAngles(1:3,4,j) = IK([xa(j), -ya(j), za(j)]);
        jointAngles(1:3,5,j) = IK([xa(j)+hexX, ya(j)-hexY, za(j)]);

        jointAngles(1:3,2,j) = IK([xb(j)+hexX, yb(j)-hexY, zb(j)]);
        jointAngles(1:3,3,j) = IK([xb(j), -yb(j), zb(j)]);
        jointAngles(1:3,6,j) = IK([xb(j)+hexX, yb(j)+hexY, zb(j)]);

    elseif (direction == 'l')
        % total trajectory
        xa = [x2,x1];           xb = [x1,x2];
        ya = [y1,y2];           yb = [y2,y1];
        za = [z2,z1];           zb = [z1,z2];

        % use IK to calculate joint angles for given trajectory
        % For tripod gait
        jointAngles(1:3,1,j) = IK([xa(j)+hexX, ya(j)+hexY, za(j)]);
        jointAngles(1:3,4,j) = IK([xb(j), -ya(j), za(j)]);
        jointAngles(1:3,5,j) = IK([xa(j)+hexX, ya(j)-hexY, za(j)]);

        jointAngles(1:3,2,j) = IK([xa(j)+hexX, yb(j)-hexY, zb(j)]);
        jointAngles(1:3,3,j) = IK([xb(j), -yb(j), zb(j)]);
        jointAngles(1:3,6,j) = IK([xa(j)+hexX, yb(j)+hexY, zb(j)]);

    elseif (direction == 'r')
        % total trajectory
        xa = [x1,x2];           xb = [x2,x1];
        ya = [y1,y2];           yb = [y2,y1];
        za = [z2,z1];           zb = [z1,z2];

        % use IK to calculate joint angles for given trajectory
        % For tripod gait
        jointAngles(1:3,1,j) = IK([xa(j)+hexX, ya(j)+hexY, za(j)]);
        jointAngles(1:3,4,j) = IK([xb(j), -ya(j), za(j)]);
        jointAngles(1:3,5,j) = IK([xa(j)+hexX, ya(j)-hexY, za(j)]);

        jointAngles(1:3,2,j) = IK([xa(j)+hexX, yb(j)-hexY, zb(j)]);
        jointAngles(1:3,3,j) = IK([xb(j), -yb(j), zb(j)]);
        jointAngles(1:3,6,j) = IK([xa(j)+hexX, yb(j)+hexY, zb(j)]);
    end
end


end

