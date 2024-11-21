function [EV_safe, EV_risky, choice, NEV_safe, NEV_risky] = noisyExpectedValueTheory(X, Y, Z, sigma)
 
    % compute noiseless expected values
    EV_safe = X;
    EV_risky = Y * Z;
     
    % compute noisy expected values
    NEV_risky = EV_risky + randn(1) * sigma;
    NEV_safe = EV_safe + randn(1) * sigma;
     
    % compute choice
    choice = NEV_safe > NEV_risky;
end