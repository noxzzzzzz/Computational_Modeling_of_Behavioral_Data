function [choice, r, cp, Q] = sim_simpleRL(T, p, alpha, beta, Q0)
    % initial values
    Q(1,:) = [Q0 Q0];
    
    % loop over experiment
    for t = 1:T
        % compute choice probability
        cp(t,:) = exp(beta * Q(t,:));
        cp(t,:) = cp(t,:) / sum(cp(t,:));
        
        % make a choice
        choice(t) = find(mnrnd(1,cp(t,:)));
        
        % sample reward (modified for +1 and -1 outcomes)
        r(t) = 2 * binornd(1, p(choice(t))) - 1;
        
        % update values
        Q(t+1,:) = Q(t,:);
        Q(t+1,choice(t)) = Q(t,choice(t)) + alpha * (r(t) - Q(t,choice(t)));
    end
end