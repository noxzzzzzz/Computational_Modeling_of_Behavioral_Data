function sigma_fit = fit(EV_safe, EV_risky, choice_sim)
 
% function handle
fHandle = @(x) -computeLogLikelihood(EV_safe, EV_risky, choice_sim, x);
 
% initial condition
X0 = 1;
 
% lower bound
LB = 0;
 
% upper bound
UB = inf;
 
% minimize the negative log likelihood
sigma_fit = fmincon(fHandle, X0, [], [], [], [], LB, UB)