function [EV_safe, EV_risky, choice] = EVtheory_survey(X, Y, Z)
 
    EV_safe = X;
    EV_risky = Y * Z;
    choice = EV_safe > EV_risky;
end
