%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Train cost function Random Forest
%
%   Author: Yankun Xi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [CostElement, CostMap] = Train_cost_func_RF(TerrainFile, ShowTerrain)

% clc
% close all
% clear all

global Classifier
global TreeBaggers
global TestData
global WholeTerrain
global Result

Train = 1;
Test = 1;
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
Classifier.TerrainTemplate = GenerateTemplate(Classifier.TerrainWidth, Classifier.TerrainLenth, Classifier.WidthNum, Classifier.DepthNum, 0); % contains 115 templates which are all 11 by 11 matrixes
land = GenerateTemplate(11,11,5,5,0);
Xtrain = [[]];
for i = 1:115
    A=reshape(land(:,:,i), 1, []);
    A=A-mean(A);
    Xtrain = [Xtrain; A];  
end
Classifier.F = Xtrain; % reshaped templates
Classifier.C = [0.2,zeros(1,16),1.1,1.2,1.3,1.4,zeros(1,5),2+zeros(1,15),1,1.2,1.4,1.6,1.8,1,1.2,1.4,1.6,1.8,repmat([0.2,0.4,1,2],1,16)]; % the cost we set artificially
save('Classifier_RF.mat', 'Classifier');



%% train the decision trees
TreeBaggers.NTrees = 100;
TreeBaggers.Method = 'regression';
TreeBaggers.MinLeaf = 1;
TreeBaggers.TB = TreeBagger(TreeBaggers.NTrees, Classifier.F, Classifier.C, 'Method', TreeBaggers.Method,'MinLeaf',TreeBaggers.MinLeaf);
save('TreeBaggers.mat', 'TreeBaggers');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Test == 1
%% Test Data
load('TreeBaggers.mat');
load('TestData.mat');
TestData = TrainingData;
Y_pre = [];
Y_oracle = [];
for i = 1:length(TestData.y)
    A = reshape(TestData.input(:,:,i),1,[]);
    A=A-mean(A);
    [Y_p, scores_, stdevs_] = predict(TreeBaggers.TB, A);
    Y_pre = [Y_pre, Y_p];
%     Y_p
    Y_oracle = [Y_oracle, TestData.y(i)];
%     TrainingData.y(i)
%     x = -0.05:0.01:0.05; % for mesh
%     y = x;
%     [X, Y] = meshgrid(x, y);
% figure;
% mesh(X,Y,reshape(A,11,11));
% axis([-0.05 0.05 -0.05 0.05 -0.05 0.05])
end
Y_ob=zeros(2,length(TestData.y));
Y_ob(1,:)=Y_pre<0.5;
Y_ob(2,:)=Y_oracle==1;
test_accuracy = sum(Y_ob(1,:)==Y_ob(2,:))/(length(TestData.y))
end

if ClassifyTerrain == 1
load('Classifier.mat');
load('TreeBaggers.mat');
[WholeTerrain.input, WholeTerrain.num, WholeTerrain.RowNum, WholeTerrain.ColNum] = InputWholeTerrain(TerrainFile, Classifier.TerrainWidth, Classifier.TerrainLenth, 0);
WholeTerrain.cost = [];
Y_oracle = [];
for i = 1:WholeTerrain.num
    percent = i/WholeTerrain.num*100
    A = reshape(WholeTerrain.input(:,:,i),1,[]);
    A=A-mean(A);
    [Y_p, scores_, stdevs_] = predict(TreeBaggers.TB, A);
    WholeTerrain.cost = [WholeTerrain.cost, Y_p];
end
WholeTerrain.y=(WholeTerrain.cost<0.7)*2-1;
n1 = WholeTerrain.num;
CostSquare = reshape(WholeTerrain.y, sqrt(n1), sqrt(n1));
CostElement = zeros(10, 10);
for i = 1:10 % row
    for j = 1:10 % col
        CostElement(i, j) = sum(sum(CostSquare(9*(i-1)+1:9*i, 9*(j-1)+1:9*j)));
    end
end
CostElement = -(CostElement);
CostMap = -(CostSquare);
Result.CostElement = CostElement;
Result.CostMap = CostMap;
save('RFResult.mat', 'Result');
end

end

% add height and slope features in the cost function
% need real terrain data,
% a function reads that terrain data and then take in 11 by 11 matrix every
% time
% train this new data