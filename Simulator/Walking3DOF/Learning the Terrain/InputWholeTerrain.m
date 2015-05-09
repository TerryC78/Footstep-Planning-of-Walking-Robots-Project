function [ input, TerrainNum, n1,  n2, LearnTerrain] = InputWholeTerrain( filename, TerrainWid, TerrainLen, ShowImg, options)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    Resolution = options.Resolution;
    Region = options.LearnRegion;
    x1 = Region(1);     y1 = Region(2); 
    x2 = Region(3);     y2 = Region(4);
    if x1 <= 5 || y1 <=5 || ...
       x2 > Resolution(1) - 5 || ...
       y2 > Resolution(2) - 5
        fprintf('x1=%d\ny1=%d\nx2=%d\ny2=%d\n', x1, y1, x2, y2);
        error('Learning Region Error!\n');
    end
    
    % read terrain file
    A = imread(filename); 
    B = im2double(A); % change data type
    [c1, c2, ~] = size(B);
    B = B(:, :, 1);   %  we only need the first layer of the matrix, and I don't understand what other layers mean
    
    % modify the resolution of the terrain by interpolation 
    MatNum(1) = Resolution(1);
    MatNum(2) = Resolution(2);
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

    % desk figure from Angel
    % load('desk.mat');
    % desk = tmp;
    % B = desk;

    % generate input matrixes as training data
    % Training data num = 20
    % idx = floor(rand(Trainingnum, 1).*(c1-11)) + 1; % random position in the height map
    % idy = floor(rand(Trainingnum, 1).*(c2-11)) + 1;

    % learn terrain in the Learning Region
    n1 = (x2-x1+1);
    n2 = (y2-y1+1);
    TerrainNum = n1 * n2;  % number of small terrains to be classified
    LearnTerrain = B(x1:x2, y1:y2);

    input = zeros(TerrainWid, TerrainLen, TerrainNum);
    input_tmp = zeros(TerrainWid, TerrainLen, n2);
    for i = 0:n1-1 % row
        for j = 0:n2-1 % col
            xl = i+x1;
            yl = j+y1;
            tmp = B(xl-5:5+xl, yl-5:5+yl);
            ave = mean(tmp(:));
            input_tmp(:,:,j+1) = tmp - ave;
            %             input(:,:,(c2-10)*(i-1)+j) = tmp - ave;
        end
        input(:,:,n2*(i)+1:n2*(i+1)) = input_tmp;
        input_tmp = zeros(TerrainWid, TerrainLen, n2);
%         fprintf('[1] Input Terrain %1.1f%% complete\n', 100*(i+1)/(n1));
    end

%      for i=1:TerrainNum
%          input(:,:,i) = input(:,:,i) - mean(mean(input(:,:,i)));
%          fprintf('[2] %1.1f%% complete\n', 100*i/TerrainNum);
%      end

    if ShowImg
        % show the input figure
        x = linspace(0,10,101);
        y = linspace(0,10,101);
        [X, Y] = meshgrid(x, y);
        for i=1:1 % i = 1:3
            figure(i)
            mesh(X, Y, B(:,:,i))
            axis([0 10 0 10 0 .5]) 
        end
    end


end

