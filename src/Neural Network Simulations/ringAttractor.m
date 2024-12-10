% Clear environment
clear;

% Parameters
N = 100; % Number of neurons
T = 200; % Number of time steps
sigma = 20 * 2 * pi / 360; % Width of connections (20 degrees in radians)
exc = 10; % Excitatory connection strength
inh = 1;  % Inhibitory connection strength

% Build the Weight Matrix
W = zeros(N, N);
for i = 1:N
    for j = 1:N
        % Compute preferred angles
        angle_i = (i-1)/N * 2 * pi;
        angle_j = (j-1)/N * 2 * pi;

        % Project onto unit circle
        v_i = [cos(angle_i), sin(angle_i)];
        v_j = [cos(angle_j), sin(angle_j)];

        % Compute distance on ring
        d_ij = sqrt(sum((v_i - v_j).^2));

        % Compute weights
        W(i, j) = exc * exp(-d_ij^2 / (2 * sigma^2)) - inh;
    end
end

% Visualize the weight matrix
figure(1); clf;
imagesc(W);
title('Weight Matrix');
xlabel('Neuron i');
ylabel('Neuron j');

% Divisive Normalization Parameters
S = 1;    % Scaling constant
K = 0.1;  % Gain constant

% Initialize Neural Activity
x = zeros(N, T + 1);
x(:, 1) = rand(N, 1) * 0.03; % Small random activity

% Update Network
for t = 1:T
    % Compute input
    a = W * x(:, t);

    % Apply ReLU (rectified linear unit)
    r = a .* (a > 0);

    % Divisive normalization activation rule
    x(:, t+1) = r / (S + K * sum(r));
end

% Visualize the evolution of activity
figure(2); clf;
imagesc(x);
title('Evolution of Neural Activity');
xlabel('Time Step');
ylabel('Neuron Number');

figure(3); clf;
plot(x(:, end));
title('Final Activity at Last Time Step');
xlabel('Neuron Number');
ylabel('Activity');
