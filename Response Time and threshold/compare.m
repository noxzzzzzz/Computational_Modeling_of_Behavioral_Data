% Parameters
A = 0.1;
c = 0.1;
z = 2;

% Calculate accuracy analytically
P_correct = 1 - exp(-2 * A * z / c^2);

% Calculate decision time analytically
T = z / A * (1 + exp(-2 * A * z / c^2));

% Display analytic results
fprintf('Analytic Accuracy (P(correct)): %.4f\n', P_correct);
fprintf('Analytic Decision Time (T): %.4f frames\n', T);
