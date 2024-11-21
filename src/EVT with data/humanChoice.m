clear
load riskyChoiceData_2024
whos
QUS'

for i = 1:length(P)
    EV_risky(i) = P(i) * V(i);
end

EV_safe = 10
f_risk = mean(rsk);
f_safe = 1 - f_risk;

individual_ids = [1, 2, 3];
sigma = 10;
Delta = [-6:0.1:6];
p_safe_softmax = softmax(sigma, Delta);


clf;
plot(EV_safe - EV_risky, f_safe, '.', 'markersize', 50)
hold on;
plot(Delta, p_safe_softmax, 'linewidth', 3)
set(gca, 'fontsize', 18)
xlabel('EV_safe - EV_risky', 'interpreter', 'none')
ylabel('probability of choosing safe option')

%I tried sigma = 10, and it is more suitable than sigma = 3. A higher value 
% makes the curve steeper, indicating that the choice is more sensitive to
% changes in the expected value. This implies that as the difference between 
% the safe and risky expected values becomes positive, the probability of 
% choosing the safe option increases more sharply. This could be interpreted 
% as the decision-maker being more rational or consistent in their risk assessment.