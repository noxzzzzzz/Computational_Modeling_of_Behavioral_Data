function accuracy = makeOneDecision(D, T, f)
    % Generate all dot directions at once using vectorized binornd
    dot_direction = binornd(1, f, T*D, 1);

    % Calculate correct and wrong counts using sum
    N_correct = sum(dot_direction);
    N_wrong = T*D - N_correct;  % No need to calculate 1-dot_direction and then sum

    % Determine the accuracy based on counts
    if N_correct > N_wrong
        accuracy = 1;
    elseif N_correct < N_wrong
        accuracy = 0;
    else
        accuracy = binornd(1,0.5);  % Random choice if tied
    end
end