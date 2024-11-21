% Part 1: One neuron, one input
x_values = linspace(-1, 1, 100);
weights_one_input = [0.5, 1, 2, -1];

clf;
for i = 1:length(weights_one_input)
    w = weights_one_input(i);
    y = x_values * w;
    
    subplot(2, 2, i);
    plot(x_values, y, 'b', 'LineWidth', 1.5); hold on;
    
    % Sample random x values and plot
    sampled_x = -1 + 2 * rand(1, 5); % Random values in [-1, 1]
    sampled_y = sampled_x * w;
    scatter(sampled_x, sampled_y, 50, 'r', 'filled');
    
    title(['One Neuron, One Input (w = ' num2str(w) ')']);
    xlabel('x');
    ylabel('y');
    grid on;
    xline(0, '--k', 'LineWidth', 0.5); % x = 0 line
    yline(0, '--k', 'LineWidth', 0.5); % y = 0 line
    legend('Output curve', 'Sampled points');
    hold off;
end
sgtitle('One Neuron, One Input');