function [ map, obs_mat, tar_mat, rob_mat ] = init_map( x_map, y_map, obs_num, tar_num, rob_num, RANDOM, CostMap )
%   init_map: input size of the map, number of the obstacles targets, 
%   robots return the terrain map
%   DEFINITION: -1 = obs, 1 = tar, 0 = robot, space = 2;
    map = 2 .* ones(x_map, y_map);
    map(1,1) = 0; % robot
%     rob_mat = [1, 1]; % starting position
    rob_mat = [2, 2];
    map(x_map-1, y_map-1)= 1; % target position
    tar_mat = [x_map-1, y_map-1];
    if RANDOM == 1
        obs_mat = floor(10 .* rand(obs_num, 2)) + 1; % obstacle
        while process_obs(obs_mat, tar_mat, rob_mat) == 1
            obs_mat = floor(10 .* rand(obs_num, 2)) + 1; % obstacle
        end
       
    elseif RANDOM == 0 % this part can be improved
        obs_num = 0;
        obs_mat = [];
        [n1, n2] = size(CostMap);
        for i = 1:n1
            for j = 1:n2
                if CostMap(i, j) > 0  % check TerrainCostMap
                    tmp = [i j];
                    obs_mat = [obs_mat; tmp];
                    obs_num = obs_num + 1;
                end
            end
        end
    end
    for i = 1:obs_num
        map(obs_mat(i,1), obs_mat(i, 2)) = -1;
    end
end

