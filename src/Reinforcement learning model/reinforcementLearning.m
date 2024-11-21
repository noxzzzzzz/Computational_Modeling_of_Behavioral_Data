% number of trials
T = 100; 
% payoff probabilities for bandits
p = [0.2 0.8];
c = 1; % example choice, chose 1
r = binornd(1, p(c))
c = 2;  % example choice, chose 2
r = binornd(1, p(c))

% learning rate
alpha = 0.1;
 
% softmax parameter
beta = 2;

% initial values
Q(1,:) = [0.5 0.5];

% trial counter
t = 1;

% compute choice probability
cp(t,:) = exp(beta * Q(t,:));
cp(t,:) = cp(t,:) / sum(cp(t,:))

mnrnd(1,cp(t,:))

% make a choice
choice(t) = find(mnrnd(1,cp(t,:)))

% sample reward
r(t) = binornd(1, p(choice(t)))

% update values
Q(t+1,:) = Q(t,:); % set all values equal to start so that unchosen value stays the same
Q(t+1,choice(t)) = Q(t,choice(t)) + alpha * (r(t) - Q(t,choice(t))) % update chosen value

for t = 1:T
 
    % compute choice probability
    cp(t,:) = exp(beta * Q(t,:));
    cp(t,:) = cp(t,:) / sum(cp(t,:));
 
    % make a choice
    choice(t) = find(mnrnd(1,cp(t,:)));
 
    % sample reward
    r(t) = binornd(1, p(choice(t)));
 
    % update values
    Q(t+1,:) = Q(t,:);
    Q(t+1,choice(t)) = Q(t,choice(t)) + alpha * (r(t) - Q(t,choice(t)));
 
end


clf; 
hold on;
GTgold = [179, 163, 105] / 255;
GTblue = [0, 48, 87] / 255;
 
plot([0 T], [1 1]*p(1), 'k--', 'linewidth', 1);
plot([0 T], [1 1]*p(2), 'k--', 'linewidth', 1);
l = plot([0:T], Q,'-', 'linewidth', 6);
ylabel('Q value')
xlabel('trial number')
ylim([0 1]);
set(gca, 'tickdir', 'out', 'fontsize', 24);
 
set(l(1,:), 'color', GTgold)
set(l(2,:), 'color', GTblue)


%Adjusting the learning rate alpha impacts the agent's speed of learning 
% and the stability of its value estimates. A low alpha close to 0 causes 
% the agent to update its estimates slowly, heavily weighting past 
% experiences and leading to stable but potentially outdated values. 
% Conversely, a high alpha near 1 makes the agent rapidly adjust its 
% estimates based on recent rewards, resulting in quick learning but 
% increased volatility due to sensitivity to noise. Selecting an appropriate 
% alpha balances the trade-off between learning efficiency and stability.

%Varying the softmax parameter beta influences the agent's 
% exploration-exploitation balance. Lower beta values make action
% selection more random, promoting exploration and allowing the agent 
% to learn accurate values by sampling all actions extensively, but may 
% lead to lower immediate rewards. Higher beta values (e.g., 10) cause the 
% agent to favor actions with higher estimated values, enhancing performance 
% in terms of maximizing cumulative rewards if the estimates are accurate. 
% However, excessive exploitation can hinder learning by reducing exploration 
% and potentially causing the agent to overlook better actions. 
% Thus, lower beta values are better for learning accurate values, 
% while higher beta values improve reward maximization through exploitation.