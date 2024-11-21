clear
% number of dots
D = 3;
% viewing time
T = 1;
% fraction of dots moving in the preffered direction
f = 0.6;

% initialize count variables
N_correct = 0;
N_wrong = 0;

% for loop to loop over all dots
for i = 1:D*T
    
    % direction is 1 when it moves in the preffered direction
    dot_direction = binornd(1, f);
    
    % update the counts
    N_correct = N_correct + dot_direction;
    N_wrong = N_wrong + (1 - dot_direction);
    
end
% display number of dots counted in "correct" direction
N_correct;
 
% display number of dots counted in "wrong" direction
N_wrong;

% compute accuracy of this choice
if N_correct > N_wrong
    accuracy = 1;
end

if N_correct < N_wrong
    accuracy = 0;
end
if N_correct == N_wrong
    accuracy = binornd(1,0.5);
end

%Observation:
%1. The accuracy increases as T increases.
%2. The accuracy increases as f increases.
%3. The accuracy will also increase if D increases.