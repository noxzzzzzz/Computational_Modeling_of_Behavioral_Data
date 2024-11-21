% number of simulations per question
N = 146;
 
% simulated value of sigma
sigma_sim = 3;
 
for i = 1:length(P)
    [~, ~, ~, choice(:,i)] = NEVtheory(N, EV_safe, P(i), V(i), sigma_sim);
end

choice_sim = 1 - choice;

clf;
subplot(1,2,1)
imagesc(choice_sim);
title('simulated data, choice_sim', 'interpreter', 'none')
xlabel('question number')
ylabel('participant number')
set(gca, 'fontsize', 18)
subplot(1,2,2)
imagesc(rsk);
title('real data, rsk')
xlabel('question number')
ylabel('participant number')
set(gca, 'fontsize', 18)

fHandle = @(x) -computeLogLikelihood(EV_safe, EV_risky, choice_sim, x);
% initial condition
X0 = 1;
 
% lower bound
LB = 0;
 
% upper bound
UB = inf;
 
% minimize the negative log likelihood
sigma_fit = fmincon(fHandle, X0, [], [], [], [], LB, UB)
