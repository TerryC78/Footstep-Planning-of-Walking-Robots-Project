function [ input, TerrainNum, c1, c2 ] = InputWholeTerrain( filename, TerrainWid, TerrainLen, ShowImg )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    A = imread(filename); 
    B = im2double(A); % change data type
    [c1, c2, c3] = size(B);
    B = B(:, :, 1);   %  we only need the first layer of the matrix, and I don't understand what other layers mean

    %% modify the resolution of the terrain height map
    % reshape the terrain height map into a 100 by 100 matrix
    % MatNum = 100;
    % idx_row = linspace(1,floor(c1/MatNum)*MatNum+1, MatNum+1);
    % idx_col = linspace(1,floor(c2/MatNum)*MatNum+1, MatNum+1);
    % B = B(idx_row, idx_col);
    % c1 = MatNum+1;
    % c2 = MatNum+1;

    % interpolate 
    MatNum = 467;
    x = linspace(0, 10, MatNum);
    y = linspace(0, 10, MatNum);
    [X, Y] = meshgrid(x, y);
    xold = linspace(0, 10, c1);
    yold = linspace(0, 10, c2);
    B = interp2(xold, yold, B, X, Y); % interpolate matrix to change resolution
    B = B';  % result from interp2 is transposed
    c1 = MatNum;
    c2 = MatNum;

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

    TerrainNum = (c1-10)*(c2-10);

    input = zeros(TerrainWid, TerrainLen, TerrainNum);
    input_tmp = zeros(TerrainWid, TerrainLen, c2-10);
    for i = 1:c1-10 % row
        for j = 1:c2-10 % col
            tmp = B(i:10+i, j:10+j);
            ave = mean(tmp(:));
            input_tmp(:,:,j) = tmp - ave;
            %             input(:,:,(c2-10)*(i-1)+j) = tmp - ave;
        end
        input(:,:,(c2-10)*(i-1)+1:(c2-10)*(i)) = input_tmp;
        input_tmp = zeros(TerrainWid, TerrainLen, c2-10);
        fprintf('[1] Input Terrain %1.1f%% complete\n', 100*i/(c1-10));
    end

%      for i=1:TerrainNum
%          input(:,:,i) = input(:,:,i) - mean(mean(input(:,:,i)));
%          fprintf('[2] %1.1f%% complete\n', 100*i/TerrainNum);
%      end

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

