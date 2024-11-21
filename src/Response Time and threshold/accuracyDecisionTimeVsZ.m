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

% Create the plot with two different y-axes
figure;
yyaxis left; % Create a y-axis on the left for decision time
plot(z_vals, meanDT, '.-', 'LineWidth', 5, 'MarkerSize', 30, 'Color', 'b');
ylabel('Average Decision Time (frames)', 'FontSize', 12);
xlabel('Decision Threshold (z)', 'FontSize', 12);

yyaxis right; % Create a y-axis on the right for accuracy
plot(z_vals, meanACC, '.-', 'LineWidth', 5, 'MarkerSize', 30, 'Color', 'r');
ylabel('Average Accuracy', 'FontSize', 12);

% Additional plot settings
title('Decision Time and Accuracy vs. Decision Threshold', 'FontSize', 14);
legend({'Average Decision Time', 'Average Accuracy'}, 'Location', 'best');
set(gca, 'FontSize', 12);
