function feature = FeatureValue(Classifier, TrainingData)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    feature = zeros(Classifier.FeatureNum, TrainingData.num);
    h = 50; % bandwith of the kernel function
    
    for i = 1:TrainingData.num  % process traning data   
%         tmp = zeros(Classifier.TerrainWidth, Classifier.TerrainLenth, Classifier.FeatureNum); % clear tmp
%         for j = 1:Classifier.FeatureNum
%             tmp(:, :, j) = TrainingData.input(:, :, i); % replicate training data 
%         end
        tmp = repmat(TrainingData.input(:, :, i), 1, 1, Classifier.FeatureNum);
        feature(:, i) = exp(sum(sum((-h*(tmp - Classifier.TerrainTemplate).^2))));   % the kernel
%         fprintf('[2] Calc Feature %1.1f%% complete \n', 100*i/TrainingData.num);
    end
    
end

