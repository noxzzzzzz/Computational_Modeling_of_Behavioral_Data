function [x_train, c_train] = make_dataset_v1(n_train)
    % Generate random points in two-dimensional space
    x_train = -10 + (10 - (-10)) * rand(n_train, 2); % Uniformly sample between -10 and 10

    % Set the constant k
    k = 0.1;

    % Compute category probabilities
    p = 1 ./ (1 + exp(-k * x_train(:, 1) .* x_train(:, 2))); % Sigmoid-like XOR function

    % Sample category labels based on probabilities
    c_train = rand(n_train, 1) < p; % Compare random values with probabilities

    % Convert logical vector to numeric (0 or 1)
    c_train = double(c_train);
end
