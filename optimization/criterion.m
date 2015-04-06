function score=criterion(p)
    % Input:   p = 28 x 1 vector of current joint angles

    global xd;
    global Rd;
    global robot;
    
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

    
    
    % ------------------ Caculate Scores ----------------- %
    
    % left wrist location and orientation
    score_x = norm(x-xd);
    diff = R*Rd';
    score_R = norm([diff(1,2), diff(1,3), diff(2,3)]);
    
    if x_switch
        score_x = score_x-5;
    end
    
    % left foot location and orientation
    score_lfx = norm(robot.j(11).position_w - [0, 0.089, 0.0811]);
    diff = robot.l(11).orientation*eye(3)';
    score_lfR = norm([diff(1,2), diff(1,3), diff(2,3)]);
    
    % right foot location and orientation
    score_rfx = norm(robot.j(17).position_w - [0, -0.089, 0.0811]);
    diff = robot.l(17).orientation*eye(3)';
    score_rfR = norm([diff(1,2), diff(1,3), diff(2,3)]);
    
    % center of mass minimum distance from edge of polygon.
    min_dist = min(0.302/2 - abs(robot_com(1)), 0.262/2 - abs(robot_com(2)));
    score_com = 0.262/2 - min_dist; % this way score is zero in the center
                                    % of the polygon of support.
    
    % score for joint limits, higher values the closer to limits.
    score_limits = 0;
    for i = 1:28
        limits = robot.j(i+1).angle_limits;
        smallest_dist = min(abs(limits(2)-robot.j(i+1).angle), abs(robot.j(i+1).angle-limits(1)));
        score_limits = score_limits + mean(limits) - smallest_dist;
    end
    
    % -------------------- Set Weights ------------------- %
    w_x = 1;
    w_R = 1;
    w_lfx = 0.05;
    w_lfR = 0.5;
    w_rfx = 0.05;
    w_rfR = 0.5;
    w_com = 0.1;
    w_limits = 1e-5;
    
    % -------------------- Combine ------------------- %
    score = w_x*score_x + w_R*score_R + w_lfx*score_lfx + w_lfR*score_lfR ...
        + w_rfx*score_rfx + w_rfR*score_rfR + w_com*score_com + w_limits*score_limits;
        
end