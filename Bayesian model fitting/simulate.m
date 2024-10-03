function choices = simulate(N, EV_safe, P, V, sigma)
 
% simulate!
for i = 1:length(P)
    [~, ~, ~, choice(:,i)] = NEVtheory(N, EV_safe, P(i), V(i), sigma);
end
 
choices = 1 - choice;