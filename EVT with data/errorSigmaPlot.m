clear
load riskyChoiceData_2024.mat
 
% compute expected values
EV_safe = 10;
EV_risky = P.*V;
 
% compute human choice curves
f_risk = mean(rsk);
f_safe = 1 - f_risk;
 
% plot human choice curve
clf;
plot(EV_safe - EV_risky, f_safe, '.', 'markersize', 50)
xlabel('EV_safe - EV_risky', 'Interpreter','none')
ylabel('probability of choosing safe option')
set(gca, 'fontsize', 18)
 
% add the softmax curve
hold on;
sigma = 3;
Delta = [-6:0.1:6];
p_safe_softmax = softmax(sigma, Delta);
plot(Delta, p_safe_softmax, 'LineWidth', 3)

% first define some sigma values
sigma_vals = [0:0.1:10];
 
% then loop through all of them to compute the error
for i = 1:length(sigma_vals)
    ERROR(i) = computeSumSquaredError(EV_safe, EV_risky, f_safe, sigma_vals(i));
end

LB = [0 -inf]; % lower bound 0 for sigma, -inf for theta
UB = [inf inf]; % upper bound inf for sigma, inf for theta
X0 = [1 0]; % initial condition 1 for sigma, 0 for theta

fHandle = @(x) twoParameterSoftmax(EV_safe, EV_risky, f_safe, x(1), x(2))

[sigmaBest, Ebest] = fmincon(fHandle, X0, [], [], [], [], LB, UB)
% now plot the error as a function of sigma_vals
clf
plot(sigma_vals, ERROR, 'linewidth', 3)
xlabel('noise parameter, \sigma') % note the \ turns it into the Greek letter sigma
ylabel('error')
set(gca, 'fontsize', 18)
hold on;
plot(sigmaBest, Ebest, '*', 'markersize', 30, 'linewidth', 3)