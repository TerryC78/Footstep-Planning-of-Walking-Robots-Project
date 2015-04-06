function part1(goal_pos, goal_rot)

close all
clear all

drc4();
draw(robot);

% set foot goal positions
left_foot_goal_pos = robot.j(11).position_w;
left_foot_goal_rot = robot.j(11).rotation;
right_foot_goal_pos = robot.j(17).position_w;
right_foot_goal_rot = robot.j(17).rotation;


% set options
options = optimset('MaxFunEvals',1000000);

% optimizing joint angles
joints0 = [joint.angle]; % all zeros

% first assume we can reach the goal
[answer,fval,exitflag]=fmincon(@reachable_criterion,joints0,[],[],[],[],[],[],@reachable_constraints,options);

% if we don't find an answer, search for unreachable goal
[answer,fval,exitflag]=fmincon(@unreachable_criterion,joints0,[],[],[],[],[],[],@unreachable_constraints,options);

    % ------------------ Helper Functions ------------------ %
    
    function ce = get_rot_dist(R,Rd)
        % returns a 1x3 vector
        T = R*Rd';
        ce = zeros(3,1);
        ce(1) = T(1,2);
        ce(2) = T(1,3);
        ce(3) = T(2,3);
    end


    % --------------------- Reachable ---------------------- %
    
    function score = reachable_criterion(p)
        % already used the constraint that the hand is at the goal, so the
        % score is just the stability and to stay away from joint limits.
        
        % apply all the forward kinematics
        for i = 1:length(robot.j)
            robot.j(i).angle = p(i);
        end
        
        % Stability:
        [robot, robot_com, robot_mass] = drc_forward_kinematics( robot );
        com_dist_to_edges = [0.302 - abs(robot_com(1)), 0.262 - abs(robot_com(2))];
        com_penalty = 0.302/2 - min(com_dist_to_edges);
        
        % Joint limits:
        total_joint_penalty = 0;
        for i = 2:length(robot)
            joint_dist_to_limits = [robot.j(i).angle_limits(2) - robot.j(i).angle, robot.j(i).angle - robot.j(i).angle_limits(1)];
            joint_penalty = mean([robot.j(i).angle_limits(2),robot.j(i).angle_limits(1)]) - min(joint_dist_to_limits);
            total_joint_penalty = total_joint_penalty + joint_penalty;
        end
        
        stability_v_joint_weight = 0.99;
        score = stability_v_joint_weight*com_penalty + (1-stability_v_joint_weight)*total_joint_penalty;
    end
    
    function [ineq_violations,eq_violations]= reachable_constraints(p)
        % apply all the forward kinematics
        for i = 1:length(robot.j)
            robot.j(i).angle = p(i);
        end
        [robot, robot_com, robot_mass] = drc_forward_kinematics( robot );
        
        % equality constraints:
        % - feet must have the same position and orientation
        % - wrist must be the same as the goal location
        % - inequality constraint keeping robot_com inside polygon of
        % support
        % - inequality constraint to keep within joint limits
        
        % keep feet locations still
        left_foot_pos = robot.j(11).position_w;
        left_foot_rot = robot.j(11).rotation;
        right_foot_pos = robot.j(17).position_w;
        right_foot_rot = robot.j(17).rotation;
        
        % left wrist location
        wrist_pos = robot.j(29).position_w;
        wrist_rot = robot.j(29).rotation;
        
    end



    % --------------------- Unreachable -------------------- %

    function score = unreachable_criterion(p)
        % apply all the forward kinematics
        for i = 1:length(robot.j)
            robot.j(i).angle = p(i);
        end
        [robot, com_robot, robot_mass] = drc_forward_kinematics( robot );
        
        % get the right right wrist location and orientation
        wrist_pos = robot.j(29).position_w;
        wrist_rot = robot.j(29).rotation;
        
        pos_error = norm(wrist_pos - goal_pos);
        rot_error = get_rot_dist(wrist_rot,goal_rot);
        
        % combine position and rotation error
        pos_v_rot_weight = 0.9;
        wrist_error = pos_v_rot_weight*pos_error + (1-pos_v_rot_weight)*rot_error;
        
        % get penalty for having com near edge of polygon of support
        com_dist_to_edges = [0.302 - abs(com_robot(1)), 0.262 - abs(com_robot(2))];
        com_penalty = 0.302/2 - min(com_dist_to_edges);
        
        % combine wrist error and com penalty
        wrist_v_com_weight = 0.9;
        score = wrist_v_com_weight*wrist_error + (1-wrist_v_com_weight)*com_penalty;
    end

    function [ineq_violations,eq_violations]= unreachable_constraints(p)
        % apply all the forward kinematics
        for i = 1:length(robot.j)
            robot.j(i).angle = p(i);
        end
        [robot, robot_com, robot_mass] = drc_forward_kinematics( robot );
        
        % equality constraints:
        % - feet must have the same position and orientation
        % - 
        
        
    end

end

