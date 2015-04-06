function [ineq_violations,eq_violations] = constraints(p)

    % Input : p = 28 x 1 vector of current joint angles

    global xd
    global Rd
    global robot
   
    % -------- Recover variables from parameters --------- %
    
    % set robot's joints to current parameter joint angles
    for i = 1:28
        robot.j(i+1).angle = p(i);
    end
    
    % set the robot's base link to the proper world coordinates and
    % orientation
    robot.j(1).position_w = p(29:31);
    robot.j(1).rotation = q_to_R(p(32:35)./norm(p(32:35)));

    % perform forward dynamics
    [robot, robot_com, robot_mass] = drc_forward_kinematics( robot );

    % Get current wrist location and orientation
    x = robot.j(29).position_w;
    R = robot.l(29).orientation;
    x_switch = round(p(36));
    
    % ---------------- Equality constraints ---------------- %
    
    % garauntee the location of the wrist and orientation
    if x_switch
        tce(1:3) = x - xd;  % error between current joint angle and desired angle
        dif = R*Rd';
        tce(4:6) = [dif(1,2), dif(1,3), dif(2,3)];
    end
    % left foot location and orientation
    
    tce(7) = robot.j(10).position_w(1) ; 
    tce(8) = robot.j(10).position_w(2) - 0.089; 
    tce(9) = robot.j(10).position_w(3) - 0.0811; 
    
    dif = robot.l(11).orientation*eye(3)';
    tce(10:12) = [dif(1,2), dif(1,3), dif(2,3)];
    
    % right foot location and orientation
    tce(13:15) = robot.j(16).position_w - [0, -0.089, 0.0811];
    dif = robot.l(17).orientation*eye(3)';
    tce(16:18) = [dif(1,2), dif(1,3), dif(2,3)];
    
    % quaternion must be a real quaternion.
    %tce(19) = 1 - norm(p(32:35));
    
    eq_violations = tce';
    
    
    % --------------- Inequality constraints --------------- %
    
    % joint limits
    tc = [];
%     for i = 1:28
%         limits = robot.j(i+1).angle_limits;
%         tc(end+1) = p(i) - limits(2); % p(i) < upper limit, p(i) - upper limit < 0
%         tc(end+1) = limits(1) - p(i); % p(i) > lower limit, lower_limit - p(i) < 0
%     end
    
    % center of mass to keep balance
    tc(end+1) = robot_com(1) - .302/2; %robot_com(1) < .302/2
    tc(end+1) = -robot_com(1) - .302/2; %robot_com(1) > -.302/2, -robot_com(1)-.302/2 < 0
    tc(end+1) = robot_com(2) - .262/2; %robot_com(2) < .262/2
    tc(end+1) = -robot_com(2) - .262/2; %robot_com(1) > -.262/2, -robot_com(1)-.262/2 < 0
    
    ineq_violations = tc';

end
