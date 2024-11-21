% Basis function visualization for all hidden neurons
clf;
n_hidden = 10; % Number of hidden neurons
x1_vals = -10:0.1:10; % Grid for x1
x2_vals = -10:0.1:10; % Grid for x2
num_rows = 2; % Number of rows in subplot
num_cols = 5; % Number of columns in subplot

% Loop through each hidden neuron
for idx = 1:n_hidden
    h = zeros(length(x2_vals), length(x1_vals)); % Initialize activity matrix

    for i = 1:length(x1_vals)
        for j = 1:length(x2_vals)
            % Get input point
            x = [x1_vals(i), x2_vals(j)];

            % Compute hidden layer activity for neuron idx
            a_hidden = x * w_hidden(:, idx) + b_hidden(idx);
            h(j, i) = 1 ./ (1 + exp(-a_hidden)); % Sigmoid activation
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
sgtitle('Basis Functions of Hidden Neurons'); % Title for the entire figure
