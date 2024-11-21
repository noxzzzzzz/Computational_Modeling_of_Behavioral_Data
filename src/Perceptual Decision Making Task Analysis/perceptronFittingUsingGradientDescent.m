% Load the data
clear;
load clicks;

% Step size for gradient descent
eta = 0.0001; % Learning rate

% Number of iterations for gradient descent
num_iterations = 200;

% Number of subjects
num_subjects = length(sub);

% Store weights for all subjects
w_all = [];
beta_all = [];

% Loop over all subjects
for sn = 1:num_subjects
    % Get the data for this subject
    X = sub(sn).clicks; % Clicks (stimuli)
    C = sub(sn).choice; % Choices

    % Logistic regression weights using glmfit
    beta = glmfit(X, C, 'binomial', 'constant', 'off');
    beta_all = [beta_all; beta'];

    % Initialize perceptron weights
    w = zeros(1, size(X, 2)); % One weight per click

    % Gradient descent process
    for count = 1:num_iterations
        % Compute predictions
        y = 1 ./ (1 + exp(-w * X')); % Sigmoid function

        % Compute prediction error
        PE = C' - y; % Error between actual and predicted choice

        % Update weights
        update = PE * X; % PE weighted by input stimuli
        w = w + eta * update; % Gradient update
    end

    % Store the final weights
    w_all = [w_all; w];
end

% Plot weight curves for 10 subjects (glmfit vs gradient descent)
figure(1); clf;
for sn = 1:min(10, num_subjects)
    subplot(5, 2, sn);
    hold on;
    plot(beta_all(sn, :), 'b', 'DisplayName', 'glmfit');
    plot(w_all(sn, :), 'r--', 'DisplayName', 'gradient descent');
    xlabel('Click number');
    ylabel('Weight');
    title(['Subject ' num2str(sn)]);
    legend;
    hold off;
end

% Compute average weights across all subjects
average_beta = mean(beta_all, 1);
average_w = mean(w_all, 1);

% Compare average weights
figure(2); clf; hold on;
plot(average_beta, 'b', 'LineWidth', 2, 'DisplayName', 'glmfit');
plot(average_w, 'r--', 'LineWidth', 2, 'DisplayName', 'gradient descent');
xlabel('Click number');
ylabel('Average weight');
title('Average Weights Across All Subjects');
legend;
hold off;
