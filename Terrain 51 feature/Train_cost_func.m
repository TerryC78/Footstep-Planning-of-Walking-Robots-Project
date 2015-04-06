clc
close all

global Classifier
global TemplateData
global TrainingData
global TestData
Train = 1;
Test = 0;

if Train == 1
%% terrain template
Classifier.WidthNum = 5; % num of different width in terrain template
Classifier.DepthNum = 5; % num of different depth in terrain template
Classifier.FeatureNum = 51; % Every Terrain Template represents a terrain feature
Classifier.TerrainWidth = 11; % size of terrain template
Classifier.TerrainLenth = 11;
Classifier.TerrainTemplate = GenerateTemplate(Classifier.TerrainWidth, Classifier.TerrainLenth, Classifier.WidthNum, Classifier.DepthNum, 0); % contains 51 templates which are all 11 by 11 matrixes
Classifier.W = zeros(Classifier.FeatureNum, 1); % the weights we are going to learn

%% use terrain template as part of the training data
TemplateData.num = 51; % training sample number
TemplateData.input = Classifier.TerrainTemplate;
TemplateData.y = [ones(1,5) -ones(1,10) ones(1,10) -ones(1,25) 1]'; % 1 = good, -1 = bad, 0 = unclassified
TemplateData.feature = FeatureValue(Classifier, TemplateData); % 51 * (Numhof training data)
% TrainingData = ExpertSystem(Classifier, TrainingData);

%% input training data and the expert gives y value
TrainingData.num = 2; % training sample number
% TrainingData.input = zeros(Classifier.TerrainWidth, Classifier.TerrainWidth, TrainingData.num); % input random terrain
TrainingData.input = InputTerrain('EasyTest.png', TrainingData.num, Classifier.TerrainWidth, Classifier.TerrainLenth, 0); % input existed terrain height map
TrainingData.y = zeros(TrainingData.num, 1); % 1 = good, -1 = bad, 0 = unclassified
TrainingData.feature = FeatureValue(Classifier, TrainingData); % 51 * (Numhof training data)
TrainingData = ExpertSystem(Classifier, TrainingData);


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
TestData.num = 100; % training sample number
% TrainingData.input = zeros(Classifier.TerrainWidth, Classifier.TerrainWidth, TrainingData.num); % input random terrain
TestData.input = InputTerrainTest('EasyTest.png', TestData.num, Classifier.TerrainWidth, Classifier.TerrainLenth, 1); % input existed terrain height map
TestData.y = zeros(TestData.num, 1); % 1 = good, -1 = bad, 0 = unclassified
TestData.feature = FeatureValue(Classifier, TestData); % 51 * (Numhof training data)
% TestData = ExpertSystem(Classifier, TestData);
TestData.y = Classify(Classifier.W, TestData.feature);
end

% add height and slope features in the cost function
% need real terrain data,
% a function reads that terrain data and then take in 11 by 11 matrix every
% time
% train this new data