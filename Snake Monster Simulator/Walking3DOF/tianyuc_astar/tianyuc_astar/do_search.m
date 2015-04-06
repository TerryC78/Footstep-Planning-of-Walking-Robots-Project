function [ OPEN_candidate, flag1] = do_search(rob_mat, tar_mat, hn, CLOSED, map)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
 
count = 1;
OPEN_candidate = [];
flag1 = 0; % flag = 0 represents no feasible solution found
% search the 8 blocks beside the successor
for i = 1:-1:-1
    for j = 1:-1:-1
        if i ~= j || i ~= 0
            flag = test_new_position(i, j, rob_mat, CLOSED, map);
            if flag == 1 % add in candidate
                s_x = rob_mat(1) + i;
                s_y = rob_mat(2) + j;
                s_hn = hn + sqrt(i*i+j*j);
                s_gn = distance(s_x, s_y, tar_mat(1), tar_mat(2));
                s_fn = s_hn + s_gn;
                %     ---calculate the cost fcn
                %     ---store the cost fcn
                OPEN_candidate(count, :) = insert_OPEN(1, s_x, s_y, rob_mat(1), rob_mat(2), s_hn, s_gn, s_fn);
                count = count + 1;
                flag1 = 1;
            end
        end
    end
end

% % find the minimal value of the cost function 
% idx = cost_value == min(cost_value(:, 1));
% % process idx
% idx = process_idx(idx);
% % renew the successor
% 
% rob_mat_new = cost_value(idx, 2:3) + rob_mat;

end

