function [ input, Terrainnum, c1, c2 ] = InputWholeTerrain( filename, TerrainWid, TerrainLen, ShowImg )
%UNTITLED Summary of this function goes here
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

% desk figure from Angel
% load('desk.mat');
% desk = tmp;
% B = desk;

% generate input matrixes as training data
% Training data num = 20
% idx = floor(rand(Trainingnum, 1).*(c1-11)) + 1; % random position in the height map
% idy = floor(rand(Trainingnum, 1).*(c2-11)) + 1;

Terrainnum = (c1-10)*(c2-10);

 input = zeros(TerrainWid, TerrainLen, Terrainnum);
 for i = 1:c1-10 % row
     for j = 1:c2-10 % col
         
        input(:,:,(c2-10)*(i-1)+j) = B(i:10+i, j:10+j);
     end
 end
 
 for i=1:Terrainnum
     
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

