clear
 
% simulate playing the bandit
r_bait = playSlotMachine(0.95, 1000);
r_switch = playSlotMachine(0.05, 100);
 
r = [r_bait r_switch];
 
% simulate learning with the prediction error version of the averaging
% model
V_predictionError = predictionErrorModel1(r);
 
% fixed learning rate model
alpha = 0.1;
V_fixed = fixedLearningRate(r, alpha);
 
clf
plot(r, '.', 'markersize', 30)
hold on;
plot(V_predictionError,'linewidth', 3)
plot(V_fixed)
plot([0 1000 1001 1100], [0.95 0.95 0.05 0.05],'k--')
legend({'rewards' 'V_predictionError' 'V_fixed' 'true reward probabilty'}, 'location', 'west', 'interpreter', 'none')
xlabel('trial number')
ylabel('reward')
set(gca, 'fontsize', 18)
