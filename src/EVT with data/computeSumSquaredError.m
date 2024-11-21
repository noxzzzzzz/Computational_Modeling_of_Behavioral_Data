function ERROR = computeSumSquaredError(EV_safe, EV_risky, f_safe, sigma)
 
% compute values of model at data points
for i = 1:length(EV_risky)
    modelPoint(i) = softmax(sigma, EV_safe - EV_risky(i));
end
 
% compute error
d = f_safe - modelPoint;
ERROR = d*d';