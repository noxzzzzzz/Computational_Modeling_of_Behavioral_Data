function V = simpleModel(r)
 
% compute running average
for t = 1:length(r)
    V(t) = mean(r(1:t));
end