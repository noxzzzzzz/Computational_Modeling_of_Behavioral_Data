% Generate XOR-like dataset
n_train = 100; % Number of training points
[x_train, c_train] = make_dataset_v1(n_train);

% Network parameters
n_hidden1 = 10; % Number of neurons in the first hidden layer
n_hidden2 = 10; % Number of neurons in the second hidden layer

% Random weights and biases for the first hidden layer
w_hidden1 = randn(2, n_hidden1); % 2 input units to n_hidden1 hidden units
b_hidden1 = randn(1, n_hidden1); % Biases for the first hidden layer

% Random weights and biases for the second hidden layer
w_hidden2 = randn(n_hidden1, n_hidden2); % n_hidden1 units to n_hidden2 units
b_hidden2 = randn(1, n_hidden2); % Biases for the second hidden layer

% Compute activations for the first hidden layer
a_hidden1 = x_train * w_hidden1 + b_hidden1; % Linear combination
h_hidden1 = 1 ./ (1 + exp(-a_hidden1)); % Sigmoid activation

% Compute activations for the second hidden layer
a_hidden2 = h_hidden1 * w_hidden2 + b_hidden2; % Linear combination
h_hidden2 = 1 ./ (1 + exp(-a_hidden2)); % Sigmoid activation

% Train the output layer using logistic regression
w_out = glmfit(h_hidden2, c_train, 'binomial');

% Test the network on a grid of input values
x1_vals = -10:0.1:10; % Grid for x1
x2_vals = -10:0.1:10; % Grid for x2
y = zeros(length(x2_vals), length(x1_vals)); % Initialize output

for i = 1:length(x1_vals)
    for j = 1:length(x2_vals)
        % Get input point
        x = [x1_vals(i), x2_vals(j)];

        % Compute activations for the first hidden layer
        a_hidden1 = x * w_hidden1 + b_hidden1;
        h_hidden1 = 1 ./ (1 + exp(-a_hidden1));

        % Compute activations for the second hidden layer
        a_hidden2 = h_hidden1 * w_hidden2 + b_hidden2;
        h_hidden2 = 1 ./ (1 + exp(-a_hidden2));

        % Compute output layer activity
        a_out = w_out(1) + h_hidden2 * w_out(2:end);
        y(j, i) = 1 ./ (1 + exp(-a_out)); % Sigmoid activation for output
    end
end

% Plot model predictions
clf;
pcolor(x1_vals, x2_vals, y); % Plot prediction surface
shading flat;
xlabel('x1');
ylabel('x2');
title('Model Predictions with Two Hidden Layers');
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

% Visualize basis functions for the second hidden layer
figure(2); clf;
num_rows = 2; % Number of rows in subplot
num_cols = 5; % Number of columns in subplot

for idx = 1:n_hidden2
    h = zeros(length(x2_vals), length(x1_vals)); % Initialize activity matrix

    for i = 1:length(x1_vals)
        for j = 1:length(x2_vals)
            % Get input point
            x = [x1_vals(i), x2_vals(j)];

            % Compute activations for the first hidden layer
            a_hidden1 = x * w_hidden1 + b_hidden1;
            h_hidden1 = 1 ./ (1 + exp(-a_hidden1));

            % Compute activations for the second hidden layer for neuron idx
            a_hidden2 = h_hidden1 * w_hidden2(:, idx) + b_hidden2(idx);
            h(j, i) = 1 ./ (1 + exp(-a_hidden2));
        end
    end

    % Plot basis function for this hidden neuron
    subplot(num_rows, num_cols, idx); % Create subplot for each neuron
    pcolor(x1_vals, x2_vals, h); % Plot the hidden unit activity
    shading flat;
    xlabel('x1');
    ylabel('x2');
    title(['Hidden Neuron ' num2str(idx)]);
    set(gca, 'TickDir', 'out', 'FontSize', 12);
    colorbar; % Add color bar to indicate activity levels
end

% Adjust layout to ensure proper spacing
sgtitle('Basis Functions of Second Hidden Layer');
