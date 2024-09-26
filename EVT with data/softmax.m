function p_safe_softmax = softmax(sigma, Delta)
 
    % compute beta
    beta = 2 / sigma * sqrt(pi);
     
    % compute softmax choice probabilities
    p_safe_softmax = 1 ./ ( 1 + exp( -beta * Delta ) );
end