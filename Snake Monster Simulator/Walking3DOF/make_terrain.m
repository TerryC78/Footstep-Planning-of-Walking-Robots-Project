% process terrain data to csv file
[c1, c2] = size(terrain);
% tmp = zeros(c1, 3*c2);
fd = fopen('terrain_trial.xyz', 'w');
for i = 1:c1
    for j = 1:c2
        fprintf(fd, '%d, %d, %f\n', 0.1*i, 0.1*j, terrain(i, j));
    end
end
fclose(fd);
% for i = 1:c1
%     for j = 1:c2
%         tmp(i, 3*j-2) = i;
%         tmp(i, 3*j-1) = j;
%         tmp(i, 3*j)   = terrain(i, j);
%     end
% end
% csvwrite('terrain_trial.csv',tmp);
%         