function [acc, DT] = oneChoice(A, c, z)
    % Initialize evidence and time
    E = 0;  % Initial evidence
    DT = 0;  % Decision time

    % Continue accumulating evidence until the threshold is crossed
    while abs(E) < z
        DT = DT + 1;  % Increment decision time
        noise = randn() * c;  % Gaussian noise with mean 0 and standard deviation c
        E = E + A + noise;  % Update evidence with drift and noise
    end

    % Determine accuracy based on which threshold was crossed
    acc = E > 0;  % True if the evidence crossed the positive threshold
end
