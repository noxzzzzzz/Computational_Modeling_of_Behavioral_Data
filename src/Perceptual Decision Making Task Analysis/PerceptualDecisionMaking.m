% Load the data
clear;
load clicks;

% Number of subjects
num_subjects = length(sub);

% Initialize variable to store all weights (beta)
beta_all = [];

% Fit perceptron model for each subject
for sn = 1:num_subjects
    % Ensure the data is not empty
    if isempty(sub(sn).clicks) || isempty(sub(sn).choice)
        warning(['Subject ' num2str(sn) ' has empty data. Skipping.']);
        continue;
    end
    
    % Fit logistic regression using glmfit
    try
        beta = glmfit(sub(sn).clicks, sub(sn).choice, 'binomial', 'constant', 'off');
        beta_all = [beta_all; beta']; % Append weights for this subject
    catch ME
        warning(['Error fitting subject ' num2str(sn) ': ' ME.message]);
    end
end

% Check if beta_all is populated
if isempty(beta_all)
    error('No valid beta values computed. Check data formatting.');
end

% Plot weight curves for 10 subjects
figure(1); clf;
hold on;
for sn = 1:min(10, size(beta_all, 1))
    plot(beta_all(sn, :), 'DisplayName', ['Subject ' num2str(sn)]);
end
xlabel('Click number');
ylabel('Weight');
title('Weight Curves for 10 Subjects');
legend;
hold off;

% Compute the average weight curve across all subjects
average_beta = mean(beta_all, 1);

% Plot the average weight curve
figure(2); clf;
plot(average_beta, 'b', 'LineWidth', 2);
xlabel('Click number');
ylabel('Average weight');
title('Average Weight Curve Across All Subjects');
