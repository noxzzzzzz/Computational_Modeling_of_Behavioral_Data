function [V, learningRates] = predictionErrorModel2(r)
    % Prediction error form of the averaging model
    % Outputs both the predictions and the learning rates used on each trial
    V = zeros(1, length(r));  % Pre-allocate for performance
    learningRates = zeros(1, length(r));  % To store learning rates
    
    for t = 1:length(r)
        if t == 1
            V(t) = r(t);  % Initialize with the first reward
            learningRates(t) = 1;  % Initial learning rate
        else
            learningRates(t) = 1/t;  % Update learning rate
            V(t) = V(t-1) + learningRates(t) * (r(t) - V(t-1));
        end
    end
end
