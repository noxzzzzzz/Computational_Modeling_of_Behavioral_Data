function r = playSlotMachine(p_win, T)
 
% simulate playing the bandit
for i = 1:T
    r(i) = binornd(1, p_win);
end