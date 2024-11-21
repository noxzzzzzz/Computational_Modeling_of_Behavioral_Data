% Generate XOR-like dataset
n_train = 100; % Number of training points
[x_train, c_train] = make_dataset_v1(n_train);

% RBF network parameters
sigma = 2; % Width of the Gaussian
x_range = 10; % Range of the grid for RBF means
m_vals = -x_range:x_range; % Preferred locations for RBF neurons

% Generate preferred locations (m) for RBF neurons
count = 1;
for i = 1:length(m_vals)
    for j = 1:length(m_vals)
        m(count, :) = [m_vals(i), m_vals(j)];
        count = count + 1;
    end
end

% Compute hidden layer activity for all training data
h_hidden = zeros(n_train, size(m, 1)); % Initialize hidden layer activity
for i = 1:n_train
    % Compute difference between input x and all preferred locations
    d = m - repmat(x_train(i, :), size(m, 1), 1);

    % Compute squared distance
    d2 = sum(d .* d, 2);

    % Compute Gaussian activation
    h_hidden(i, :) = exp(-d2 / (2 * sigma^2));
end

% Train output perceptron using logistic regression
w_out = glmfit(h_hidden, c_train, 'binomial');

% Evaluate the network on a grid of input values
x1_vals = -10:0.1:10; % Grid for x1
x2_vals = -10:0.1:10; % Grid for x2
y = zeros(length(x2_vals), length(x1_vals)); % Initialize output

for i = 1:length(x1_vals)
    for j = 1:length(x2_vals)
        % Get input point
        x = [x1_vals(i), x2_vals(j)];

        % Compute hidden layer activity for this input
        d = m - repmat(x, size(m, 1), 1);
        d2 = sum(d .* d, 2);
        h = exp(-d2 / (2 * sigma^2));

        % Compute output layer activity
        a_out = w_out(1) + h' * w_out(2:end);
        y(j, i) = 1 ./ (1 + exp(-a_out)); % Sigmoid activation for output
    end
end

% Plot model predictions
clf;
pcolor(x1_vals, x2_vals, y); % Plot prediction surface
shading flat;
xlabel('x1');
ylabel('x2');
title('Model Predictions with RBF Network');
colorbar;

% Plot training data points
hold on;
i1 = c_train == 1; % Points with label 1
i0 = c_train == 0; % Points with label 0
l(1) = plot(x_train(i0, 1), x_train(i0, 2), 'o', 'MarkerFaceColor', 'w', 'LineWidth', 2, 'MarkerSize', 10);
l(2) = plot(x_train(i1, 1), x_train(i1, 2), 'v', 'MarkerFaceColor', 'w', 'LineWidth', 2, 'MarkerSize', 10);
legend(l, 'Class 0', 'Class 1');
set(gca, 'TickDir', 'out', 'FontSize', 12);
hold off;

% Visualize basis functions for the RBF hidden layer
figure(2); clf;
x = [1, 2]; % Example input to visualize basis functions
d = m - repmat(x, size(m, 1), 1);
d2 = sum(d .* d, 2);
h = exp(-d2 / (2 * sigma^2)); % Hidden layer activity for the input
pcolor(m_vals, m_vals, reshape(h, length(m_vals), length(m_vals)));
shading flat;
xlabel('m1');
ylabel('m2');
title('RBF Basis Function Activity');
colorbar;
