%% Plot
close all
p1 = [0.9216, 0.9020, 0.8824];  % 51
p2 = [0.9043, 0.8696, 0.8261];  % 115
p22 = [0.7, .74, .76]; % 51
p3 = [0.8592, 0.8218, 0.7849];  % 51 
p33 = [.86, .9, .885]; % 115
p4 = [0.8977, 0.8788, 0.8635];  % 115
p5 = [0.6, 0.65, .7];           % 51
p6 = [.85, .95, 1];             % 115
x = [20, 50, 200];              % Incoming samples

figure
% plot(x, p1)
plot(x, p5, 'r', 'LineWidth', 2);
hold on
plot(x, p22, 'b', 'LineWidth', 2);
hold on 
plot(x, p1, 'k', 'LineWidth', 2);
hold on 
plot(x, p3, 'g', 'LineWidth', 2);
hold on
axis([20, 200, 0, 1])
grid on
title('Accuracy of the classifier with 51 features')
xlabel('Number of incoming training examples')
ylabel('Accuracy')
legend('Test Samples Accuracy','Total Training Accuracy', 'Template Accuracy', 'Incoming Samples Accuracy','Location','SouthEast')

figure
% plot(x, p1)
plot(x, p6, 'r', 'LineWidth', 2);
hold on
plot(x, p33, 'b', 'LineWidth', 2);
hold on 
plot(x, p2, 'k', 'LineWidth', 2);
hold on 
plot(x, p4, 'g', 'LineWidth', 2);
hold on
axis([20, 200, 0, 1])
grid on
title('Accuracy of the classifier with 115 features')
xlabel('Number of incoming training examples')
ylabel('Accuracy')
legend('Test Samples Accuracy','Total Training Accuracy', 'Template Accuracy', 'Incoming Samples Accuracy','Location','SouthEast')
