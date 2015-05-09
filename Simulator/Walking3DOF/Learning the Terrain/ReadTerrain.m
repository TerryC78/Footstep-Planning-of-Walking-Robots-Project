function [ ret ] = ReadTerrain(filename, Show)

% generate terrain from terrain height mape all; clear all
    A = imread(filename); 
    B = im2double(A); % change data type
    [c1, c2, ~] = size(B);
    B = B(:, :, 1);   %  we only need the first layer of the matrix, and I don't understand what other layers mean
    
    % modify the resolution of the terrain by interpolation 
    MatNum(1) = 2400;
    MatNum(2) = 2400;
    x = linspace(0, 10, MatNum(1));
    y = linspace(0, 10, MatNum(2));
    [X, Y] = meshgrid(x, y);
    xold = linspace(0, 10, c1);
    yold = linspace(0, 10, c2);
    B = interp2(xold, yold, B, X, Y); % interpolate matrix to change resolution
    B = B';  % result from interp2 is transposed


    % scale the terrain height to desired height
    BMax = max(max(max(B)));
    BMin = min(min(min(B)));
    BScale = (BMax - BMin);
    B = B / 10 / BScale;  % usually be 0-0.1

% generate input matrixes as training data
% % Training data num = 20
% idx = floor(rand(20, 1).*(c1-11)) + 1; % random position in the height map
% idy = floor(rand(20, 1).*(c2-11)) + 1;

% reshape the terrain height map into a 100 by 100 matrix

% x = linspace(0,10,c2);
% y = linspace(0,10,c1);
[X, Y] = meshgrid(x, y);

% global WholeTerrain
% Result = zeros(91, 91);
% for i = 1:91
%     Result(i, :) = WholeTerrain.y(91*(i-1)+1:91*i, 1);
% end

if Show == 1
for i=1:1 % i = 1:3
    
    figure
    mesh(X, Y, B(:,:,i))
    axis([0 10 0 10 0 .5])
    hold on
    
end
end
ret = B(:, :, 1);

end