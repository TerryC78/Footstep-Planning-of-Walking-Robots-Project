%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Train cost function
%
%   Author: Tianyu Chen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [CostElement, CostMap] = Train_cost_func(TerrainFile, ShowTerrain)

% clc
% close all
% clear all

global Classifier
global TemplateData
global TrainingData
global TestData
global WholeTerrain

Train = 0;
Test = 0;
ClassifyTerrain = 1;

%% show terrain
if ShowTerrain == 1
    ReadTerrain(TerrainFile);
end

if Train == 1
%% terrain template
Classifier.WidthNum = 5; % num of different width in terrain template
Classifier.DepthNum = 5; % num of different depth in terrain template
Classifier.FeatureNum = 51+16*4; % Every Terrain Template represents a terrain feature
Classifier.TerrainWidth = 11; % size of terrain template
Classifier.TerrainLenth = 11;
Classifier.TerrainTemplate = GenerateTemplate(Classifier.TerrainWidth, Classifier.TerrainLenth, Classifier.WidthNum, Classifier.DepthNum, 0); % contains 51 templates which are all 11 by 11 matrixes
Classifier.W = zeros(Classifier.FeatureNum, 1); % the weights we are going to learn
save('Classifier.mat', 'Classifier');

%% use terrain template as part of the training datac
TemplateData.num = Classifier.FeatureNum; % training sample number
TemplateData.input = Classifier.TerrainTemplate;
TemplateData.y = [ones(1,5) -ones(1,10) ones(1,10) -ones(1,25) 1 repmat([1 1 -1 -1], 1, 16)]'; % 1 = good, -1 = bad, 0 = unclassified
TemplateData.feature = FeatureValue(Classifier, TemplateData); % 51 * (Numhof training data)
% TrainingData = ExpertSystem(Classifier, TrainingData);

%% input training data and the expert gives y value
TrainingData.num = 50; % training sample number
% TrainingData.input = zeros(Classifier.TerrainWidth, Classifier.TerrainWidth, TrainingData.num); % input random terrain
TrainingData.input = InputTerrain('Gentle.jpg', TrainingData.num, Classifier.TerrainWidth, Classifier.TerrainLenth, 0); % input existed terrain height map
TrainingData.y = zeros(TrainingData.num, 1); % 1 = good, -1 = bad, 0 = unclassified
TrainingData.feature = FeatureValue(Classifier, TrainingData); % 51 * (Numhof training data)
TrainingData = ExpertSystem(Classifier, TrainingData);
% save('TestData.mat', 'TrainingData');

%% l1-regularized LR and use fmincon to do optimzation
options = optimset('Algorithm', 'Interior-Point', 'MaxFunEvals', 1000000, 'MaxIter', 10000,'TolX',1.00e-25);
[w, fval, exitflag, output, lambda, grad, hessian] = fmincon(@criterion, Classifier.W, [], [], [], [], [], [], @constraints, options);
Classifier.W = w;
y1 = Classify(Classifier.W, TrainingData.feature);
y2 = Classify(Classifier.W, TemplateData.feature);
R1 = sum(y1 == TrainingData.y)/TrainingData.num
R2 = sum(y2 == TemplateData.y)/TemplateData.num
% error('stop!\n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Test == 1
%% Test Data
load('TestData.mat');
TestData = TrainingData;
% TestData.num = 50; % test example number
% TestData.input = InputTerrainTest('EasyTest.png', TestData.num, Classifier.TerrainWidth, Classifier.TerrainLenth, 1); % input existed terrain height map
% TestData.y = zeros(TestData.num, 1); % 1 = good, -1 = bad, 0 = unclassified
% TestData.feature = FeatureValue(Classifier, TestData); % 51 * (Numhof training data)
% TestData = ExpertSystem(Classifier, TestData);
yTest = Classify(Classifier.W, TestData.feature);
RTest = sum(yTest == TestData.y)/TestData.num
end

if ClassifyTerrain == 1
load('Classifier.mat')
[WholeTerrain.input, WholeTerrain.num, WholeTerrain.RowNum, WholeTerrain.ColNum] = InputWholeTerrain(TerrainFile, Classifier.TerrainWidth, Classifier.TerrainLenth, 0);
WholeTerrain.feature = FeatureValue(Classifier, WholeTerrain);
WholeTerrain.y = Classify(Classifier.W, WholeTerrain.feature);    % 91*91
[n1, ~] = size(WholeTerrain.y);
CostSquare = reshape(WholeTerrain.y, sqrt(n1), sqrt(n1));
CostElement = zeros(10, 10);
for i = 1:10 % row
    for j = 1:10 % col
        CostElement(i, j) = sum(sum(CostSquare(9*(i-1)+1:9*i, 9*(j-1)+1:9*j)));
    end
end
CostElement = -(CostElement);
CostMap = -(CostSquare);

end

end

% add height and slope features in the cost function
% need real terrain data,
% a function reads that terrain data and then take in 11 by 11 matrix every
% time
% train this new data