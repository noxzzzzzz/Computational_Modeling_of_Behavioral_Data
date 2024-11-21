load data

for sn = 1:length(sub)
 
    % get the choices and responses
    c = sub(sn).response1;
    r = sub(sn).outcome1;
 
    % what were the choice and responses on the last trial?
    c_last = [nan; c(1:end-1)];
    r_last = [nan; r(1:end-1)];
 
    % get the indices of trials when the last reward was a loss or a win
    i_lost = r_last == -1;
    i_won = r_last == +1;
 
    % now what's the mean number of times that the current choice (c) is equal
    % to the last choice (c_last) on the previously lost trials?
    m(sn,1) = nanmean(c(i_lost) == c_last(i_lost));
 
    % same thing for wins ...
    m(sn,2) = nanmean(c(i_won) == c_last(i_won));
end

% Plot the probabilities
M = nanmean(m);
S = nanstd(m) / sqrt(length(sub)); % standard error of the mean
figure(1); clf;
e = errorbar(M, S);
set(e, 'linewidth', 2, 'marker','o', 'markersize', 10, 'markerfacecolor', 'w')
ylim([0 1])
xlim([0.5 2.5]);
set(gca, 'xtick', 1:2, 'xticklabel', {'Loss (-1)', 'Win (+1)'}, 'fontsize', 12);
ylabel('p(stay)')
xlabel('last reward')
title('Simulated RL Model: Probability of Staying After Loss or Win');
