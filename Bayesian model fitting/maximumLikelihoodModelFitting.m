clear
 
% load the data
load riskyChoiceData_2024.mat
 
% compute expected values
EV_safe = 10;
EV_risky = P.*V;
 
% compute log likelihood as a function of sigma
sigma_vals = [0.01:0.01:10];
for i = 1:length(sigma_vals)
    logLikelihood(i) = computeLogLikelihood(EV_safe, EV_risky, rsk, sigma_vals(i));
end
 
% plot the log likelihood
clf;
plot(sigma_vals, logLikelihood, 'LineWidth', 3)
xlabel('noise parameter, \sigma')
ylabel('log likelihood')
set(gca, 'fontsize', 18)

fHandle = @(x) -computeLogLikelihood(EV_safe, EV_risky, rsk, x);
% initial condition
X0 = 1;
 
% lower bound
LB = 0;
 
% upper bound
UB = inf;
 
% minimize the negative log likelihood
sigmaBest = fmincon(fHandle, X0, [], [], [], [], LB, UB)

