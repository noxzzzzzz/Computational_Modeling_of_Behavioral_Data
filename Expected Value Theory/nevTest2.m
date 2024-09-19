clear
Y = [0.25:0.01:0.75];  % Range of probabilities
Z = 20;              % Potential payoff for risky option
N = 100;   % Number of trials to average out randomness
sigma = 2;
for i = 1:length(Y)
    [EV_safe(i), EV_risky(i), p_safe(i), choice] = NEVtheory(N, 10, Y(i), 20, sigma)
end

clf;
plot(EV_safe - EV_risky, p_safe, 'LineWidth', 3)
xlabel('EV_safe - EV_risky', 'interpreter', 'none')
ylabel('probability of choosing safe')
set(gca, 'fontsize', 18)
xlim([-20 20])
ylim([0 1])