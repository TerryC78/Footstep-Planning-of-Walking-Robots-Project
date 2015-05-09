function [ input ] = InputTerrainTest(filename, Testnum, TerrainWid, TerrainLen, ShowImg)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
A = imread(filename); 
B = im2double(A); % change data type
[c1, c2, c3] = size(B);
% reshape the terrain height map into a 100 by 100 matrix

idx_row = linspace(1,floor(c1/100)*100+1, 101);
idx_col = linspace(1,floor(c2/100)*100+1, 101);
B = B(idx_row, idx_col);
% x = linspace(0,10,101);
% y = linspace(0,10,101);

% first scale the terrain height to desired height
BMax = max(max(max(B)));
BMin = min(min(min(B)));
BScale = (BMax - BMin);
B = B / 20 / BScale;  % usually be 0-0.05

% generate input matrixes as training data
% Training data num = 20
% idx = floor(rand(Trainingnum, 1).*(c1-11)) + 1; % random position in the height map
% idy = floor(rand(Trainingnum, 1).*(c2-11)) + 1;
c1 = 101;
c2 = 101;

 input = zeros(TerrainWid, TerrainLen, (c1-11)*(c2-11));
 for i = 1:91
     for j = 1:91
     
        input(:,:,i) = B(i:i+10, j:j+10) - mean(mean(B(i:i+10, j:j+10)));
        
     end
 end


if ShowImg
    % show the input figure
    x = linspace(0,10,c2);
    y = linspace(0,10,c1);
    [X, Y] = meshgrid(x, y);

    for i=1:1 % i = 1:3

        figure(i)
        mesh(X, Y, B(:,:,i))
        axis([0 10 0 10 0 .5])
        
    end
end
    
end

