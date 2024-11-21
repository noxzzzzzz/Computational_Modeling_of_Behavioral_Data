clear
% Define constants
D = 10;           % Number of dots
f = 0.55;         % Fraction of dots moving in the correct direction
z = 40;           % Decision threshold
numTrials = 1000; % Number of decisions to simulate

% Initialize arrays to store data
responseTimes = zeros(1, numTrials);
accuracies = zeros(1, numTrials);

% Simulate decisions
for k = 1:numTrials
    [choice, DT] = simulate_ddm(D, f, z);
    responseTimes(k) = DT;
    accuracies(k) = choice;
end

% Compute average accuracy and response time
averageAccuracy = mean(accuracies);
averageResponseTime = mean(responseTimes);


figure;
histogram(responseTimes, 'BinWidth', 1);  % Specify bin width if necessary
xlabel('Response Time (frames)');
ylabel('Frequency');
title('Histogram of Response Times');
set(gca, 'FontSize', 14);  % Set font size for readability

averageAccuracy
averageResponseTime