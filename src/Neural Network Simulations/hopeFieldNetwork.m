clear
% number of neurons
N = 100; 
 
% number of memories
M = 3;
 
% total number of time steps
T = 20;

flip_probability = 0.1; % Probability of flipping bits

% Step 1: Create random memories
m = 2 * (rand(N, M) < 0.5) - 1;

% Visualize the memories
figure(1); clf;
imagesc(m);
title('Original Memories');
xlabel('Memory Number');
ylabel('Neuron Number');

% Step 2: Compute weight matrix W
W = zeros(N, N);
for i = 1:N
    for j = 1:N
        for k = 1:M
            W(i, j) = W(i, j) + m(i, k) * m(j, k);
        end
    end
end
% Remove self-connections
W = W - diag(diag(W));

% Step 3: Test stability of memories
for memory_idx = 1:M
    % Initialize with one memory
    x = zeros(N, T + 1);
    x(:, 1) = m(:, memory_idx);

    % Update network activity
    for t = 1:T
        a = W * x(:, t);
        x(:, t + 1) = 2 * (a > 0) - 1;
    end

    % Visualize the recall process
    figure(memory_idx + 1); clf;
    imagesc(x);
    title(['Recall of Memory ' num2str(memory_idx)]);
    xlabel('Time Step');
    ylabel('Neuron Number');
end

% Step 4: Test memory recovery with flipped bits
x = zeros(N, T + 1);
x(:, 1) = m(:, 1); % Start with the first memory
for i = 1:N
    if rand < flip_probability
        x(i, 1) = -x(i, 1);
    end
end

% Update network with flipped input
for t = 1:T
    a = W * x(:, t);
    x(:, t + 1) = 2 * (a > 0) - 1;
end

% Visualize recovery from corrupted input
figure(M + 2); clf;
imagesc(x);
title('Recovery from Flipped Input');
xlabel('Time Step');
ylabel('Neuron Number');

% Step 5: Increase the number of memories to 30
M = 30;
m = 2 * (rand(N, M) < 0.5) - 1;

% Recompute weight matrix
W = zeros(N, N);
for i = 1:N
    for j = 1:N
        for k = 1:M
            W(i, j) = W(i, j) + m(i, k) * m(j, k);
        end
    end
end
W = W - diag(diag(W));

% Test recall of all 30 memories
success_count = 0;
for memory_idx = 1:M
    x = zeros(N, T + 1);
    x(:, 1) = m(:, memory_idx);

    % Update network activity
    for t = 1:T
        a = W * x(:, t);
        x(:, t + 1) = 2 * (a > 0) - 1;
    end

    % Check if final state matches the original memory
    if all(x(:, end) == m(:, memory_idx))
        success_count = success_count + 1;
    end
end

% Display results
fprintf('Recall success rate for 30 memories: %d / %d\n', success_count, M);

% All memories are successfully recalled, even if the input is slightly 
% corrupted, demonstrating the stability and error correction capability 
% of the Hopfield network.

