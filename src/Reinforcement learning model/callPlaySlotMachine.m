clear
 
% probability of winning
p_win = 0.4;
 
% number of plays
T = 10;
 
% simulate playing the bandit
r = playSlotMachine(p_win, T)

V_simple = simpleModel(r);

clf;
plot(r, '.', 'markersize', 30)
hold on
plot(V_simple, '-', 'linewidth', 3)
plot([0 T], [1 1]*p_win, 'k--')
legend({'rewards' 'V_simple' 'p_win'}, 'interpreter', 'none')
xlabel('play number')
ylabel('reward')
set(gca, 'fontsize', 18)