clear
 
% load the data
load riskyChoiceData_2024.mat
 
% compute expected values
EV_safe = 10;
EV_risky = P.*V;
participant = rsk(2,:);

sigma_vals = [0.01:0.01:10];
for i = 1:length(sigma_vals)
    logLikelihood(i) = computeLogLikelihood(EV_safe, EV_risky, participant, sigma_vals(i));
end

k = -max(logLikelihood);
X = 10.^(logLikelihood + k);
integral = sum(X);

rsk(2,:)

posterior = X / integral;
clf;
plot(sigma_vals, posterior, 'LineWidth', 3)
xlabel('noise parameter, \sigma')
ylabel('posterior p(\sigma | data)')
set(gca, 'fontsize', 18)

[~, max_idx] = max(posterior);
best_sigma = sigma_vals(max_idx);
fprintf('Best-fitting sigma for Participant 2: %.2f\n', best_sigma);

% A narrower peak indicates high confidence in the estimate, while a wider
% peak suggests greater uncertainty. For participant 2, if the posterior 
% is relatively narrow, we are confident about the estimate of σ. 
% If it's wide, there's more uncertainty.

hold on;
participants = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]; % List of participant numbers
colors = lines(length(participants)); % Generate distinguishable colors

for idx = 1:length(participants)
    participant_num = participants(idx);
    participant_choices = rsk(participant_num,:);
    
    % Compute log-likelihoods for each sigma value
    for i = 1:length(sigma_vals)
        sigma = sigma_vals(i);
        logLikelihood(i) = computeLogLikelihood(EV_safe, EV_risky, participant_choices, sigma);
    end
    
    % Compute posterior
    k = -max(logLikelihood);
    X = 10.^(logLikelihood + k);
    posterior = X / sum(X);
    
    % Plot posterior
    plot(sigma_vals, posterior, 'LineWidth', 1.5, 'Color', colors(idx,:))
end

legend(arrayfun(@(x) sprintf('Participant %d', x), participants, 'UniformOutput', false))
hold off;
xlabel('Noise parameter, \sigma')
ylabel('Posterior p(\sigma | data)')
set(gca, 'FontSize', 15)

