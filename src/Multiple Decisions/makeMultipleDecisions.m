function average_accuracy = makeMultipleDecisions(D, T, f, nDecisions, dead_time)
    % Adjust T for dead time
    effective_T = max(T - dead_time, 0);  % Ensure non-negative viewing time

    % Vectorize binornd to generate all decisions at once
    dot_direction = binornd(1, f, D*effective_T, nDecisions);

    % Sum along the rows to get correct counts for each decision
    N_correct = sum(dot_direction, 1);

    % Calculate accuracies for each decision
    accuracies = N_correct > (D*effective_T - N_correct);  % True if more correct than wrong

    % Compute the average accuracy
    average_accuracy = mean(accuracies);
end
