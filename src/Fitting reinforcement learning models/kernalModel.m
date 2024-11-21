% --- Part 1: Simulate the Choice Kernel Model ---

% Experiment parameters
T = 100;        % Number of trials
p = [0.2 0.8];  % Payoff probabilities for bandits

% Model parameters
alpha = 0.1;    % Learning rate for Q-values
beta  = 2;      % Inverse temperature for softmax
kappa = 0.1;    % Learning rate for the choice kernel
eta   = 2;      % Weight of the choice kernel
Q0    = 0;      % Initial Q-values
CK0   = 0;      % Initial choice kernel values

% Initialize arrays
Q = zeros(T+1, 2);     % Q-values for options 1 and 2
Q(1,:) = [Q0, Q0];

CK = zeros(T+1, 2);    % Choice kernel values for options 1 and 2
CK(1,:) = [CK0, CK0];

choice = zeros(T,1);   % Choices made
r = zeros(T,1);        % Rewards received
cp = zeros(T,2);       % Choice probabilities

for t = 1:T
    % Compute combined values (Q-values and choice kernel)
    net_value = beta * Q(t,:) + eta * CK(t,:);
    
    % Compute choice probabilities using softmax
    cp(t,:) = exp(net_value);
    cp(t,:) = cp(t,:) / sum(cp(t,:));
    
    % Make a choice based on the probabilities
    choice(t) = find(rand < cumsum(cp(t,:)), 1);
    
    % Simulate reward based on the chosen option
    current_choice = choice(t);
    if rand < p(current_choice)
        r(t) = 1;   % Reward of +1 (win)
    else
        r(t) = -1;  % Reward of -1 (loss)
    end
    
    % Update Q-values based on received reward
    delta = r(t) - Q(t, current_choice);
    Q(t+1, :) = Q(t, :);  % Carry over previous Q-values
    Q(t+1, current_choice) = Q(t, current_choice) + alpha * delta;
    
    % Update choice kernel
    CK(t+1, :) = (1 - kappa) * CK(t, :);  % Decay previous CK values
    CK(t+1, current_choice) = CK(t+1, current_choice) + kappa * 1;  % Increment CK for chosen option
end

% Plot Q-values and Choice Kernel
figure(1); clf;

% Plot Q-values
subplot(2,1,1); hold on;
plot(0:T, Q, 'LineWidth', 2);
xlabel('Trial Number');
ylabel('Q-value');
title('Q-values Over Trials');
legend({'Option 1', 'Option 2'});
grid on;

% Plot Choice Kernel values
subplot(2,1,2); hold on;
plot(0:T, CK, 'LineWidth', 2);
xlabel('Trial Number');
ylabel('Choice Kernel Value');
title('Choice Kernel Over Trials');
legend({'Option 1', 'Option 2'});
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
title('Choice Kernel Model: Probability of Staying After Loss or Win');
ylim([0 1]);
grid on;
