//////////////////////////////////////////////////////////////////////
//  Learning the terrain
//	----by L1-regularization Logistic Regression with supervised learning
//  Auther: Tianyu Chen (Terry)
//  Email:  tianyuc@andrew.cmu.edu
//  2015/04/07
//
/////////////////////////////////////////////////////////////////////

To use the code,
=> run "Train_cost_func.m" 

Then Matlab asks you to classify a group of small terrains. Click the left botton if you think the terrain is good, click the right button otherwise. This is superivised learning. After 50 training samples, the classifier learns an optimal weights W of the terrain cost function, which is stored in Classifier.W

[Notes]:
(1) TrainingData.num is the number of training data;
(2) Terrain templates are generated in Function GenerateTemplate, if you want to see the terrain template, change the last argument of GenerateTemplate to 1;
(3) The input terrain height map can be changed by modifying the first argument of InputTerrain function;

To see the terrain height map:
=> run "ReadTerrain.m"

A pdf summary report is also in this folder
