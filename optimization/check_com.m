function [res] = check_com(robot_com)

if abs(robot_com(1)) <= 0.302/2 && abs(robot_com(2)) <= 0.262/2
    res = 'satisfied';
    fprintf('distance: %d\n',min(0.302/2 - abs(robot_com(1)), 0.262/2 - abs(robot_com(2))))
else
    res = 'not satisfied';
end

end