% Clear environment
clear;

% Parameters
T = 1000;      % Number of time steps for training data
N = 100;       % Number of neurons in the recurrent layer
s = 0.2;       % Sparsity of weights
tau = 10;      % Time delay for target signal

% Generate training signal
u = rand(T, 1); % Random 1-dimensional input signal

% Initialize weight matrices
Win = (rand(N, 1) < s) .* randn(N, 1); % Input weights
W = (rand(N, N) < s) .* randn(N, N);   % Recurrent weights

% Normalize spectral radius to ensure echo state property
rho = max(abs(eig(W))); % Compute spectral radius
W = W / rho * 0.9;      % Scale to ensure stability

% Generate activity of the recurrent layer
x = zeros(N, T); % Initialize recurrent layer activity
for t = 2:T
    x(:, t) = tanh(W * x(:, t-1) + Win * u(t-1));
end

% Prepare training data
X = x(:, 1:T-tau)';         % Recurrent layer activity (predictors)
y = u((1+tau):T);           % Delayed target signal

% Train output weights using linear regression
% (Linear regression using glmfit for simplicity)
Wout = glmfit(X, y, 'normal', 'constant', 'off');

% Test the network
u_test = rand(T, 1);        % Generate new input signal for testing
x_test = zeros(N, T);       % Initialize recurrent layer activity for testing
for t = 2:T
    x_test(:, t) = tanh(W * x_test(:, t-1) + Win * u_test(t-1));
end
X_test = x_test(:, 1:T-tau)'; % Prepare test predictors
y_test = u_test((1+tau):T);   % True delayed signal
y_pred = X_test * Wout;       % Predicted delayed signal

% Evaluate the results
figure(1); clf;
plot(y_test, 'b', 'DisplayName', 'True Signal');
hold on;
plot(y_pred, 'r', 'DisplayName', 'Predicted Signal');
title(['Echo State Machine: Delayed Signal Prediction (\tau = ' num2str(tau) ')']);
xlabel('Time Step');
ylabel('Signal');
legend;
grid on;

% Calculate Mean Squared Error (MSE)
mse = mean((y_test - y_pred).^2);
disp(['Mean Squared Error: ', num2str(mse)]);
