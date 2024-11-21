clear
[EV_safe(1), EV_risky(1), choice(1)] = EVtheory_survey(10, 0.25, 19.74);
[EV_safe(2), EV_risky(2), choice(2)] = EVtheory_survey(10, 0.75, 19.97);

clf;
plot([-20 0 0 20], [0 0 1 1], 'LineWidth', 3);
xlabel('EV_safe - EV_risky', 'interpreter', 'none');
ylabel('probability of choosing safe');
set(gca, 'fontsize', 18);


% Here we can notice that the safe one is selected in the first case.
% The risky one is selected in the second case.