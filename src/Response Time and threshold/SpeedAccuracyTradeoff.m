clear
% Parameters
D = 10;              % Number of dots
f = 0.55;            % Fraction of dots moving in correct direction
z_vals = [2, 4, 8, 16, 32]; % Threshold values
numSimulations = 100; % Simulations per threshold

% Arrays to hold mean values
meanACC = zeros(1, length(z_vals));
meanDT = zeros(1, length(z_vals));

% Loop over each threshold value
for j = 1:length(z_vals)
    z = z_vals(j);
    accuracies = zeros(1, numSimulations);
    responseTimes = zeros(1, numSimulations);

    % Simulate decisions
    for i = 1:numSimulations
        [accuracies(i), responseTimes(i)] = simulate_ddm(D, f, z);
    end
    
    % Calculate mean accuracy and decision time
    meanACC(j) = mean(accuracies);
    meanDT(j) = mean(responseTimes);
end

figure;
plot(meanDT, meanACC, '.-', 'LineWidth', 5, 'MarkerSize',30, 'Color', 'g');
xlabel('Average Decision Time (frames)', 'FontSize', 12);
ylabel('Average Accuracy', 'FontSize', 12);
title('Speed-Accuracy Tradeoff', 'FontSize', 14);
grid on; % Add grid for better readability
set(gca, 'FontSize', 12); % Set font size for axes
