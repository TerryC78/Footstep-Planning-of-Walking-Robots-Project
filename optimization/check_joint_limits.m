function [res] = check_joint_limits(robot)

res = 'satisfied';
for i = 2:length(robot.j)
    limits = robot.j(i).angle_limits;
    if robot.j(i).angle < limits(1) || robot.j(i).angle > limits(2)
        res = 'failed';
        break;
    end
end

end