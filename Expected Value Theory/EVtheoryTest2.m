clear

Y = [0.25:0.01:0.75];

for i = 1:length(Y)
    [EV_safe(i), EV_risky(i), choice(i)] = EVtheory_survey(10, Y(i), 20);
end

clf;
plot([-20 0 0 20], [0 0 1 1], 'LineWidth', 3);
xlabel('EV_safe - EV_risky', 'interpreter', 'none');
ylabel('probability of choosing safe');
set(gca, 'fontsize', 18);

% Here we can notice that the safe one is selected in the first case.
% The risky one is selected in the second case.