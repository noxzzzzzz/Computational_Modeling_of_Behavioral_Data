function [choice, DT] = simulate_ddm(D, f, z)
    N_correct = 0;
    N_wrong = 0;
    i = 1;
    maxFrames = 1000;  % Set a reasonable upper limit to prevent infinite loops
    Delta = zeros(1, maxFrames);  % Preallocate for performance

    % Initial condition
    Delta(1) = N_correct - N_wrong;

    % Process each frame until the threshold is reached or maxFrames
    while abs(Delta(i)) < z && i < maxFrames
        for j = 1:D
            % Randomly sample the direction of each dot
            dot_direction = binornd(1, f);
            
            % Update counts based on the direction
            N_correct = N_correct + dot_direction;
            N_wrong = N_wrong + (1 - dot_direction);
        end
        
        % Increment frame counter
        i = i + 1;
        
        % Compute the difference for this frame
        Delta(i) = N_correct - N_wrong;
    end

    % Adjust for the extra increment
    i = i - 1;

    % Determine accuracy based on the sign of Delta at decision time
    choice = Delta(i) > 0;  % True if positive, false otherwise

    % Decision time in frames
    DT = i;
end
