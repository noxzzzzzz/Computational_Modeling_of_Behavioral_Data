function p = theoreticalChoiceCurve(EV_diff, beta)
    p = 1 ./ (1 + exp(-beta * EV_diff));
end
