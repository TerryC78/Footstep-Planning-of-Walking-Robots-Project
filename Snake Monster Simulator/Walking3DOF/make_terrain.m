% process terrain data to csv file
[c1, c2] = size(terrain);

% tmp = zeros(c1, 3*c2);
c1_ = floor(c1/20);
c2_ = floor(c2/20);
x = linspace(0, 10, c1_);
y = linspace(0, 10, c2_);
[X, Y] = meshgrid(x, y);
xold = linspace(0, 10, c1);
yold = linspace(0, 10, c2);
B = interp2(xold, yold, terrain, X, Y);

fd = fopen('EasyTest.xyz', 'w');
for i = 1:c1_
    for j = 1:c2_
        % x-y defined as global coordinate
        fprintf(fd, '%f, %f, %f\n', x(i), y(j), B(i, j)); 
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