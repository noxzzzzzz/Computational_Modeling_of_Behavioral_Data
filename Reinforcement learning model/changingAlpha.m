clear

% Simulate playing the bandit
r_bait = playSlotMachine(0.95, 1000);
r_switch = playSlotMachine(0.05, 100);

r = [r_bait r_switch];

% Fixed learning rate models with different alphas
alphas = [0.1, 0.01, 0.5];
V_fixed_alpha = cell(length(alphas), 1);

for i = 1:length(alphas)
    V_fixed_alpha{i} = fixedLearningRate(r, alphas(i));
end

% Plotting the results
clf
plot(r, '.', 'markersize', 10)
hold on;
colors = {'r', 'g', 'b'};
for i = 1:length(alphas)
    plot(V_fixed_alpha{i}, 'Color', colors{i}, 'LineWidth', 2)
end
plot([0 1000 1001 1100], [0.95 0.95 0.05 0.05], 'k--', 'LineWidth', 2)
legend_entries = [{'Rewards'}, arrayfun(@(a) sprintf('V\\_fixed (\\alpha=%.2f)', a), alphas, 'UniformOutput', false), {'True Reward Probability'}];
legend(legend_entries, 'Location', 'best', 'Interpreter', 'none')
xlabel('Trial Number')
ylabel('Value Estimate')
set(gca, 'FontSize', 14)
title('Fixed Learning Rate Model with Different \\alpha Values')

% we've observed how the fixed learning rate model's adaptability and
% sensitivity to noise.
%Higher α: Faster adaptation, more sensitivity to noise.
%Lower α: Slower adaptation, less sensitivity to noise.


% part 6: In the fixed learning rate model, setting the learning rate 
% alpha = 1 makes the value estimate V(t) equal to the most recent reward 
% r(t), causing the model to ignore all past information and react solely 
% to new data—resulting in rapid adaptation but high sensitivity to noise. 
% Conversely, when alpha = 0, the value estimate remains constant 
% regardless of new rewards, effectively stopping learning and making the 
% model unresponsive to changes. These special cases demonstrate how the 
% learning rate alpha influences the balance between adaptability and
% stability: higher alpha values lead to faster learning and quick 
% adaptation to changes but increase susceptibility to random fluctuations, 
% while lower alpha values provide greater stability and resistance to 
% noise but slow down the adaptation process. This explains the behaviors 
% observed in the simulations from Part 5, where different alpha values 
% resulted in varying rates of learning and responsiveness to changes 
% in reward probabilities.