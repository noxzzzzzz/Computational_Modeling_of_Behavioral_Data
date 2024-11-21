% Part 2: One neuron, two inputs
x1_values = linspace(-1, 1, 100);
x2_values = linspace(-1, 1, 100);
[x1_mesh, x2_mesh] = meshgrid(x1_values, x2_values);

weights_two_inputs = [0.5, 0.5; 1, -1; 2, 1; -1, -0.5];

clf;
for i = 1:size(weights_two_inputs, 1)
    w1 = weights_two_inputs(i, 1);
    w2 = weights_two_inputs(i, 2);
    y = x1_mesh * w1 + x2_mesh * w2;
    
    subplot(2, 2, i);
    contourf(x1_mesh, x2_mesh, y, 50, 'LineColor', 'none'); % Contour plot
    colormap cool; colorbar;
    hold on;
    
    % Sample random x1 and x2 values and plot
    sampled_x1 = -1 + 2 * rand(1, 5); % Random values in [-1, 1]
    sampled_x2 = -1 + 2 * rand(1, 5);
    sampled_y = sampled_x1 * w1 + sampled_x2 * w2; % Corresponding outputs
    scatter(sampled_x1, sampled_x2, 50, 'y', 'filled', 'MarkerEdgeColor', 'k');
    
    title(['Two Inputs (w1 = ' num2str(w1) ', w2 = ' num2str(w2) ')']);
    xlabel('x1');
    ylabel('x2');
    grid on;
    legend('Contour plot', 'Sampled points');
    hold off;
end
sgtitle('One Neuron, Two Inputs');
