% --- Part 1: Simulate the Random Responding Model ---

% Experiment parameters
T = 100;        % Number of trials
p = [0.2 0.8];  % Payoff probabilities for bandits

% Model parameter
bias = 0.7;     % Probability of choosing option 1

% Initialize choices and rewards
choice = zeros(T,1);
r = zeros(T,1);

% Simulate choices and rewards
for t = 1:T
    % Simulate choice based on bias
    if rand < bias
        choice(t) = 1;  % Choose option 1
    else
        choice(t) = 2;  % Choose option 2
    end
    
    % Simulate reward based on payoff probability
    current_choice = choice(t);
    if rand < p(current_choice)
        r(t) = 1;   % Reward of +1
    else
        r(t) = -1;  % Reward of -1
    end
end

% Plot the cumulative choice probability of choosing option 1
figure(1); clf; hold on;
cum_choice_prob = cumsum(choice == 1) ./ (1:T)';
plot(1:T, cum_choice_prob, 'linewidth', 2);
xlabel('Trial Number');
ylabel('Cumulative Probability of Choosing Option 1');
title('Random Responding Model with Side Bias');
ylim([0 1]);
grid on;

% --- Part 3: Compute p(stay) After Wins and Losses ---

% Previous choices and rewards
choice_last = [nan; choice(1:end-1)];
r_last = [nan; r(1:end-1)];

% Indices for trials where the last reward was a loss or a win
i_lost = r_last == -1;
i_won = r_last == +1;

% Probability of staying after a loss
p_stay_after_loss = nanmean(choice(i_lost) == choice_last(i_lost));

% Probability of staying after a win
p_stay_after_win = nanmean(choice(i_won) == choice_last(i_won));

% Display the results
fprintf('Probability of staying after a loss: %.4f\n', p_stay_after_loss);
fprintf('Probability of staying after a win: %.4f\n', p_stay_after_win);

% --- Part 5: Plot the Probabilities ---

% Store the probabilities in an array
p_stay = [p_stay_after_loss, p_stay_after_win];

% Plot the probabilities
figure(2); clf;
bar(1:2, p_stay, 0.5, 'FaceColor', [0.2 0.6 0.8]);
set(gca, 'xtick', 1:2, 'xticklabel', {'Loss (-1)', 'Win (+1)'}, 'fontsize', 12);
ylabel('Probability of Staying');
xlabel('Last Reward');
title('Random Responding Model: Probability of Staying After Loss or Win');
ylim([0 1]);
grid on;
