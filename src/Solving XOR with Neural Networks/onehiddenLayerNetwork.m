% Generate XOR-like dataset
n_train = 100; % Number of training points
[x_train, c_train] = make_dataset_v1(n_train);

% Network parameters
n_hidden = 10; % Number of hidden neurons
w_hidden = randn(2, n_hidden); % Random weights for hidden layer
b_hidden = randn(1, n_hidden); % Random biases for hidden layer

% Compute hidden layer activation
a_hidden = x_train * w_hidden + b_hidden; % Linear combination
h = 1 ./ (1 + exp(-a_hidden)); % Sigmoid activation

% Train output layer using logistic regression
w_out = glmfit(h, c_train, 'binomial');

% Test model performance on a grid of input values
x1_vals = -10:0.1:10; % Grid for x1
x2_vals = -10:0.1:10; % Grid for x2
y = zeros(length(x2_vals), length(x1_vals)); % Initialize output

for i = 1:length(x1_vals)
    for j = 1:length(x2_vals)
        % Get input point
        x = [x1_vals(i), x2_vals(j)];

        % Compute hidden layer activity
        a_hidden = x * w_hidden + b_hidden;
        h = 1 ./ (1 + exp(-a_hidden));

        % Compute output layer activity
        a_out = w_out(1) + h * w_out(2:end);
        y(j, i) = 1 ./ (1 + exp(-a_out)); % Sigmoid activation for output
    end
end

% Plot model predictions
figure(1); clf;
pcolor(x1_vals, x2_vals, y); % Plot prediction surface
shading flat;
xlabel('x1');
ylabel('x2');
title('Model Predictions');
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
