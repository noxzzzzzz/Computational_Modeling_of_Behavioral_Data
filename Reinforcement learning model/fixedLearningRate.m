function V = fixedLearningRate(r, alpha)
 
for t = 1:length(r)
    if t == 1
        V(t) = r(t);
    else
        V(t) = V(t-1) + alpha * (r(t) - V(t-1));
    end
    
end