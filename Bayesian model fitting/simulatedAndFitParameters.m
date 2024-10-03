clear
 
load riskyChoiceData_2024.mat
 
EV_safe = 10;
N = 146; % simulated number of participants
 
for i = 1:100 % repeat 100 times
    
    % set simulated sigma value randomly between 0 and 10
    sigma_sim(i) = rand*10;
    
    % simulate choices
    choice_sim = simulate(N, EV_safe, P, V, sigma_sim(i));
    
    % fit simulated choices
    sigma_fit(i) = fit(EV_safe, P.*V, choice_sim);
end

clf;
plot(sigma_sim, sigma_fit, '.', 'markersize', 30)
hold on;
plot([0 10], [0 10], 'k--') % put line of equality on there
xlabel('simulated noise, \sigma_{sim}')
ylabel('fit noise, \sigma_{fit}')
set(gca, 'fontsize', 18)

% More data leads to better parameter estimates with less variability.
% What I learn: Researchers should design experiments with sufficient sample
% sizes to achieve reliable parameter estimates.

