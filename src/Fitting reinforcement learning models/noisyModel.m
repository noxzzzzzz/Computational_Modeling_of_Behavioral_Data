% --- Part 1: Simulate the Noisy Win-Stay-Lose-Shift Model ---

% Experiment parameters
T = 100;        % Number of trials
p = [0.2 0.8];  % Payoff probabilities for bandits

% Model parameter
epsilon = 0.1;  % Noise parameter (probability of random choice)

% Initialize choices and rewards
choice = zeros(T,1);
r = zeros(T,1);

% Initialize the first choice randomly
choice(1) = randi(2);  % Randomly choose between option 1 and 2

for t = 1:T
    if t > 1
        if rand < (1 - epsilon)
            % Follow WSLS strategy
            if r(t-1) == 1
                % Win: Stay with the same choice
                choice(t) = choice(t-1);
            else
                % Loss: Switch to the other choice
                choice(t) = 3 - choice(t-1);
            end
        else
            % With probability epsilon, choose randomly
            choice(t) = randi(2);
        end
    end
    
    % Simulate reward based on the chosen option
    current_choice = choice(t);
    if rand < p(current_choice)
        r(t) = 1;   % Reward of +1 (win)
    else
        r(t) = -1;  % Reward of -1 (loss)
    end
end

% Plot the choices over trials
figure(1); clf; hold on;
plot(1:T, choice, 'o-', 'linewidth', 2);
xlabel('Trial Number');
ylabel('Choice (1 or 2)');
title('Noisy Win-Stay-Lose-Shift Model: Choices Over Time');
ylim([0.8 2.2]);
yticks([1 2]);
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
title('Noisy Win-Stay-Lose-Shift Model: Probability of Staying After Loss or Win');
ylim([0 1]);
grid on;
