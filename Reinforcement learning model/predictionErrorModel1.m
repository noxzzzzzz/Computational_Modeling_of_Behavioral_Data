function V = predictionErrorModel1(r)
 
% prediction error form of the averaging model
 
for t = 1:length(r)
    if t == 1
        V(t) = r(t);
    else
        V(t) = V(t-1) + 1/t * (r(t) - V(t-1));
    end
    
end