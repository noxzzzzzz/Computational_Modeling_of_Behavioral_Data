% Load the data
load data

% Number of subjects
numSubjects = length(sub);

% Initialize matrices to store results
m = zeros(numSubjects, 2);   % Session 1 results
m2 = zeros(numSubjects, 2);  % Session 2 results

% Loop over subjects
for sn = 1:numSubjects

    % --- Session 1 ---
    % Get the choices and outcomes
    c = sub(sn).response1;
    r = sub(sn).outcome1;

    % Choices and outcomes on the last trial
    c_last = [nan; c(1:end-1)];
    r_last = [nan; r(1:end-1)];

    % Indices for trials where the last reward was a loss or a win
    i_lost = r_last == -1;
    i_won = r_last == +1;

    % Probability of staying after a loss
    m(sn,1) = nanmean(c(i_lost) == c_last(i_lost));

    % Probability of staying after a win
    m(sn,2) = nanmean(c(i_won) == c_last(i_won));

    % --- Session 2 ---
    % Get the choices and outcomes
    c = sub(sn).response2;
    r = sub(sn).outcome2;

    % Choices and outcomes on the last trial
    c_last = [nan; c(1:end-1)];
    r_last = [nan; r(1:end-1)];

    % Indices for trials where the last reward was a loss or a win
    i_lost = r_last == -1;
    i_won = r_last == +1;

    % Probability of staying after a loss
    m2(sn,1) = nanmean(c(i_lost) == c_last(i_lost));

    % Probability of staying after a win
    m2(sn,2) = nanmean(c(i_won) == c_last(i_won));
end

% Compute group averages and standard errors
M1 = nanmean(m);
S1 = nanstd(m) / sqrt(numSubjects);

M2 = nanmean(m2);
S2 = nanstd(m2) / sqrt(numSubjects);

% Plot the results
figure(4); clf; hold on;

% Plot Session 1
e1 = errorbar(1:2 - 0.05, M1, S1, 'o-', 'linewidth', 2, 'markersize', 10, ...
    'markerfacecolor', 'w', 'color', [0 0.4470 0.7410]);  % Blue color

% Plot Session 2
e2 = errorbar(1:2 + 0.05, M2, S2, 's--', 'linewidth', 2, 'markersize', 10, ...
    'markerfacecolor', 'w', 'color', [0.8500 0.3250 0.0980]);  % Orange color

% Customize the plot
ylim([0 1]);
xlim([0.5 2.5]);
set(gca, 'xtick', 1:2, 'xticklabel', [-1 +1]);
ylabel('p(stay)');
xlabel('last reward');
legend({'Session 1', 'Session 2'}, 'Location', 'Best');
title('Average Win-Stay/Lose-Shift Behavior (Sessions 1 & 2)');
hold off;

% Statistical tests
% Paired t-test for p(stay) after loss between sessions
[~, p_loss] = ttest(m(:,1), m2(:,1));

% Paired t-test for p(stay) after win between sessions
[~, p_win] = ttest(m(:,2), m2(:,2));

% Display p-values
fprintf('P-value for difference in p(stay) after loss: %.4f\n', p_loss);
fprintf('P-value for difference in p(stay) after win: %.4f\n', p_win);

% The significant difference in p(stay) after a loss suggests that 
% participants altered their behavior between sessions. 
% For example, they might have become more inclined to switch options 
% after a loss in session 2 compared to session 1.




