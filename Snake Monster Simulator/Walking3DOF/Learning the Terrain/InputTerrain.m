function [ input ] = InputTerrain(filename, Trainingnum, TerrainWid, TerrainLen, ShowImg)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
A = imread(filename); 
B = im2double(A); % change data type
[c1, c2, c3] = size(B);

% reshape the terrain height map into a 100 by 100 matrix
idx_row = linspace(1,floor(c1/100)*100+1, 101);
idx_col = linspace(1,floor(c2/100)*100+1, 101);
B = B(idx_row, idx_col);
c1 = 101;
c2 = 101;

% first scale the terrain height to desired height
BMax = max(max(max(B)));
BMin = min(min(min(B)));
BScale = (BMax - BMin);
B = B / 10 / BScale;  % usually be 0-0.1

% generate input matrixes as training data
% Training data num = 20
idx = floor(rand(Trainingnum, 1).*(c1-11)) + 1; % random position in the height map
idy = floor(rand(Trainingnum, 1).*(c2-11)) + 1;

 input = zeros(TerrainWid, TerrainLen, Trainingnum);
 for i=1:Trainingnum
     
     input(:,:,i) = B(idx(i):idx(i)+10, idy(i):idy(i)+10);
 
 end
 
 for i=1:Trainingnum
     
     input(:,:,i) = input(:,:,i) - mean(mean(input(:,:,i)));
 
 end



if ShowImg
    % show the input figure
    x = linspace(0,10,101);
    y = linspace(0,10,101);
%     x = linspace(0,10,c2);
%     y = linspace(0,10,c1);
    [X, Y] = meshgrid(x, y);

    for i=1:1 % i = 1:3

        figure(i)
        mesh(X, Y, B(:,:,i))
        axis([0 10 0 10 0 .5])
        
    end
end

end

