% Generate some random rewards
r = randn(1, 100);  % 100 random rewards

% Calculate predictions and learning rates using the prediction error model
[V_predErr, learningRates] = predictionErrorModel2(r);

% Plotting the learning rates
clf;
plot(learningRates, 'k-', 'LineWidth', 2);
xlabel('Trial');
ylabel('Learning Rate');
title('Learning Rate Decay Over Trials');
grid on;

