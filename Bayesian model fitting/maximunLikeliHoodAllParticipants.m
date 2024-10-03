clear;
load riskyChoiceData_2024.mat

EV_safe = 10;
EV_risky = P .* V;

sigma_vals = 0.01:0.01:10;
num_sigma = length(sigma_vals);

[num_participants, ~] = size(rsk);

logLikelihoods = zeros(num_participants, num_sigma);

for participant = 1:num_participants
    participant_choices = rsk(participant, :);
    for i = 1:num_sigma
        sigma = sigma_vals(i);
        logLikelihoods(participant,i) = computeLogLikelihood(EV_safe, EV_risky, participant_choices, sigma);
    end
end


clf;
hold on;

colors = lines(num_participants);

for participant = 1:num_participants
    plot(sigma_vals, logLikelihoods(participant, :), 'LineWidth', 1.5, 'Color', colors(participant, :));
end

xlabel('Noise parameter, \sigma')
ylabel('Log-likelihood')
title('Log-likelihood vs. \sigma for Each Participant', 'FontSize', 14, 'HorizontalAlignment', 'center')
set(gca, 'FontSize', 18)
hold off;



