clear
 
% load the data
load riskyChoiceData_2024.mat
 
% compute expected values
EV_safe = 10;
EV_risky = P.*V;
 


sigma_vals = [0.01:0.01:10];
for i = 1:length(sigma_vals)
    logLikelihood(i) = computeLogLikelihood(EV_safe, EV_risky, rsk, sigma_vals(i));
end

k = -max(logLikelihood);
X = 10.^(logLikelihood + k);
integral = sum(X);


posterior = X / integral;
clf;
plot(sigma_vals, posterior, 'LineWidth', 3)
xlabel('noise parameter, \sigma')
ylabel('posterior p(\sigma | data)')
set(gca, 'fontsize', 18)