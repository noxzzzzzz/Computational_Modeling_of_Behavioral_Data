N = 100;
sigma = 5;
[EV_safe(1), EV_risky(1), p_safe(1)] = NEVtheory(N, 10, 0.25, 19.74, sigma);
[EV_safe(2), EV_risky(2), p_safe(2)] = NEVtheory(N, 10, 0.75, 19.97, sigma);


fprintf('probability for Scenario 1 (25%% chance of $19.74): %d\n', p_safe(1));
fprintf('probability for Scenario 2 (75%% chance of $19.97): %d\n', p_safe(2));
