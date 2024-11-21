% Experiment parameters
T = 100;       % number of trials
p = [0.2 0.8]; % payoff probabilities for bandits

% Model parameters
alpha = 0.1;   % learning rate
beta  = 2;     % softmax parameter
Q0    = 0;     % initial Q-values

% Simulate simple RL model
[choice, r, cp, Q] = sim_simpleRL(T, p, alpha, beta, Q0);

% Plotting the Q-values
clf; hold on;
GTgold = [179, 163, 105] / 255;
GTblue = [0, 48, 87] / 255;

% Calculate expected rewards
E_r1 = p(1)*1 + (1 - p(1))*(-1);  % Expected reward for bandit 1
E_r2 = p(2)*1 + (1 - p(2))*(-1);  % Expected reward for bandit 2

% Plot expected rewards
plot([0 T], [1 1]*E_r1, 'k--', 'linewidth', 1);
plot([0 T], [1 1]*E_r2, 'k--', 'linewidth', 1);

% Plot Q-values
l = plot([0:T], Q,'-', 'linewidth', 6);
ylabel('Q value')
xlabel('Trial Number')
ylim([-1 1]);
set(gca, 'tickdir', 'out', 'fontsize', 24);


set(l(1,:), 'color', GTgold)
set(l(2,:), 'color', GTblue)