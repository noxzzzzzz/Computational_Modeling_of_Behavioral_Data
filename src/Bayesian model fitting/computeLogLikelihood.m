function logLikelihood = computeLogLikelihood(EV_safe, EV_risky, rsk, sigma)

beta = 1 /sigma * sqrt(pi/2);
 
for i = 1:size(rsk, 1) % loop over participants
    for j = 1:size(rsk, 2) % loop over questions
        if rsk(i,j) == 0
            % chose safe option
            p_cGivenSigma(i,j) = 1 / (1 + exp( beta * (EV_risky(j) - EV_safe)));
        else
            % chose risky option
            p_cGivenSigma(i,j) = 1 - 1 / (1 + exp( beta * (EV_risky(j) - EV_safe)));
        end
    end
end
logLikelihood = sum(sum(log10(p_cGivenSigma)));
