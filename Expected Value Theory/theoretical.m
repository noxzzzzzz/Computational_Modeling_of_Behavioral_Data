clear;
Y = 0.25:0.01:0.75;  
Z = 20;             
N = 100;             
sigma = 2;        
X = 10;            



for i = 1:length(Y)
    [EV_safe(i), EV_risky(i), p_safe(i)] = NEVtheory(N, X, Y(i), Z, sigma);
end

% Calculate the theoretical choice probabilities
beta = 0.1;  % Adjust beta based on your model specifics
p_theoretical = theoreticalChoiceCurve(EV_safe - EV_risky, beta);

% Plotting both curves for comparison
clf;
plot(EV_safe - EV_risky, p_safe, 'LineWidth', 3, 'DisplayName', 'Simulated Data');  % Simulated curve
hold on;
plot(EV_safe - EV_risky, p_theoretical, 'r--', 'LineWidth', 3, 'DisplayName', 'Theoretical Curve');  % Theoretical curve

xlabel('EV_safe - EV_risky', 'interpreter', 'none');
ylabel('Probability of choosing safe');
title('Comparison of Theoretical and Simulated Choice Curves');
set(gca, 'fontsize', 18);
xlim([-20 20]);
ylim([0 1]);
legend show;  
grid on;    
hold off;
