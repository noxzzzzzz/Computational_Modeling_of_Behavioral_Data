clear;

% Parameters
D = 10;              % Number of dots
f = 0.55;            % Fraction of dots moving in correct direction
z = 40;              % Threshold for decision
maxFrames = 30;    

% Initialize count variables and frame counter
N_correct = 0;
N_wrong = 0;
i = 1;
Delta = zeros(1, maxFrames);  % Preallocate to improve performance

% Initial condition
Delta(1) = N_correct - N_wrong;

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
accuracy = Delta(i) > 0;  % True if positive, false otherwise

% Decision time in frames
DT = i;


clf; 
 
l = plot(Delta,'.-');
set(l, 'linewidth', 4, 'markersize', 20);
hold on; 
plot([0 length(Delta)+1], [1 1] * z, 'k--')
plot([0 length(Delta)+1], [1 1] * -z, 'k--')
xlabel('frame number')
ylabel('evidence \Delta')
set(gca, 'fontsize', 18)

