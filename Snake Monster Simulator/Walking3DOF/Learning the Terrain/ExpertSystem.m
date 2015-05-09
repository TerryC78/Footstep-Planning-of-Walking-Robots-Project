function [ TrainingData ] = ExpertSystem(Classifier, TrainingData)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    x = -0.05:0.01:0.05; % for mesh
    y = x;
    [X, Y] = meshgrid(x, y);
    Plus = 0; Minus = 0;
    
    for i = 1:TrainingData.num
        fprintf('%d/%d training example.\nPlus: %d, Minus: %d\n', i, TrainingData.num, Plus, Minus);
%         TrainingData.input(:, :, i) = 0.04*rand(Classifier.TerrainWidth, Classifier.TerrainLenth)-0.02;
        figure(1)
        subplot(2,2,1);
        mesh(X, Y, TrainingData.input(:, :, i));
        title('3D-view','Color','blue');
        view(3);
        axis([-0.05 0.05 -.05 .05 -.025 .025])
        subplot(2,2,2);
        mesh(X, Y, TrainingData.input(:, :, i));
        view(-90, 0);
        axis([-0.05 0.05 -.05 .05 -.025 .025])
        title('Left View')
        subplot(2,2,3);
        mesh(X, Y, TrainingData.input(:, :, i));
        view(0, 90);
        axis([-0.05 0.05 -.05 .05 -.025 .025])
        title('Top View')
        subplot(2,2,4);
        mesh(X, Y, TrainingData.input(:, :, i));
        view(0,0);
        axis([-0.05 0.05 -.05 .05 -.025 .025])
        title('Front View')   
%         axis([-0.05 0.05 -.05 .05 -.05 .05])
        
        if i == 1
            h=msgbox('Click the left button if you think the terrain is good, click right button otherwise');  
            uiwait(h,5); % wait for 5 sec
        end
        if ishandle(h) == 1
            delete(h);
        end
        [xval,yval,but]=ginput(1);
        if but == 1 % left button
            TrainingData.y(i) = 1;
            Plus = Plus + 1;
        end
        if but == 3 % right button
            TrainingData.y(i) = -1;
            Minus = Minus + 1;
        end
        clear figure 1
    end
    
    close figure 1
    
end

