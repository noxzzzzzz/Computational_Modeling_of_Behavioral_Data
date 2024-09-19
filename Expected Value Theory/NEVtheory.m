function [EV_safe, EV_risky, p_safe, choice] = NEVtheory(N, X, Y, Z, sigma)
 
    for i = 1:N
        [EV_safe, EV_risky, choice(i)] = noisyExpectedValueTheory(X, Y, Z, sigma);
    end
    p_safe = mean(choice);
end