clear

D = 100;
T = 1;
f = 0.6;
nDecisions = 100;

accuracies = zeros(1, nDecisions);  % Storage for each decision's accuracy

for i = 1:nDecisions
    accuracies(i) = makeOneDecision(D, T, f);
end

average_accuracy = mean(accuracies);  % Compute and display the average accuracy
disp(['Average Accuracy: ', num2str(average_accuracy)]);
