function [nLL, cp, trial_likelihood, Q] = lik_simpleRL_new(choice, r, alpha, beta, Q0)
    % Number of trials
    T = length(choice);
    
    % Initialize Q-values
    Q(1,:) = [Q0 Q0];
    
    for t = 1:T
        % Compute choice probabilities
        cp(t,:) = exp(beta * Q(t,:));
        cp(t,:) = cp(t,:) / sum(cp(t,:));
        
        % Handle NaN choices
        if isnan(choice(t))
            trial_likelihood(t) = NaN;
        else
            trial_likelihood(t) = cp(t, choice(t));
        end
        
        % Update Q-values
        Q(t+1,:) = Q(t,:);
        if ~isnan(choice(t))
            Q(t+1, choice(t)) = Q(t, choice(t)) + alpha * (r(t) - Q(t, choice(t)));
        end
    end
    
    % Compute negative log likelihood, ignoring NaNs
    nLL = -nansum(log(trial_likelihood));
end
