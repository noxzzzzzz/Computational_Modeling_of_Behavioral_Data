clear;
Y = 0.25:0.01:0.75;  
Z = 20;             
N = 100;             
sigma = 2;        
X = 10;            



for i = 1:length(Y)
    [EV_safe(i), EV_risky(i), p_safe(i)] = NEVtheory(N, X, Y(i), Z, sigma);
end

% Compute softmax probabilities using the provided function
p_safe_softmax = softmax(sigma, EV_safe - EV_risky);

% Assuming p_safe contains the simulated probabilities for the same Delta
% Load or compute your p_safe based on your previous simulations here

% Plotting the softmax curve along with the simulated curve
clf;  % Clear the figure
plot(EV_safe - EV_risky, p_safe_softmax, 'r-', 'LineWidth', 3, 'DisplayName', 'Softmax Theoretical Curve');
hold on;
plot(EV_safe - EV_risky, p_safe, 'b-', 'LineWidth', 3, 'DisplayName', 'Simulated Data');

xlabel('EV_safe - EV_risky', 'interpreter', 'none');
ylabel('Probability of choosing safe');
set(gca, 'fontsize', 18);
xlim([min(Delta) max(EV_safe - EV_risky)]);
ylim([0 1]);
legend('show');
title('Comparison of Theoretical Softmax and Simulated Choice Curves');
grid on;
hold off;

%They are proportianlly similar.