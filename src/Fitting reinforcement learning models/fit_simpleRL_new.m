function [Xfit, nLL_best] = fit_simpleRL_new(choice, r, Q0)
    % Lower and upper bounds on parameters
    LB = [0 0];    % [alpha beta]
    UB = [1 inf];  % Learning rate alpha is between 0 and 1
    
    % Initial parameter values
    X0 = [0.5 1];
    
    % Objective function handle
    obFunc = @(x) lik_simpleRL_new(choice, r, x(1), x(2), Q0);
    
    % Optimize parameters using fmincon
    options = optimset('Display', 'off');  % Suppress output
    [Xfit, nLL_best] = fmincon(obFunc, X0, [], [], [], [], LB, UB, [], options);
end
