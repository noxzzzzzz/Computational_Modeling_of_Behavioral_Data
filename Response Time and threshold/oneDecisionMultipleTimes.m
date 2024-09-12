clear
% Define parameters
A = 0.1;
c = 0.1;
z = 2;
numTrials = 1000;

% Arrays to store outcomes
accuracies = zeros(1, numTrials);
decisionTimes = zeros(1, numTrials);

% Run the simulation
for i = 1:numTrials
    [acc, DT] = oneChoice(A, c, z);
    accuracies(i) = acc;
    decisionTimes(i) = DT;
end

% Calculate average accuracy and decision time
averageAccuracy = mean(accuracies);
averageDecisionTime = mean(decisionTimes);

% Display the results
fprintf('Average Accuracy: %.2f%%\n', averageAccuracy * 100);
fprintf('Average Decision Time: %.2f frames\n', averageDecisionTime)
