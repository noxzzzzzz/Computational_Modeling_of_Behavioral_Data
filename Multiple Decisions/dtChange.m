
clear

D = 10;
T_vals = 1:5:21;  % Viewing times adjusted for dead time
COH = [3.2, 6.4, 12.8, 25.6, 51.2]/100;  % Coherence levels
f_vals = (COH + 1) / 2;
nDecisions = 1000;
dead_time = 2;
gold = [1, 0.84, 0];

% Matrix to store average accuracies
average_accuracies = zeros(length(T_vals), length(f_vals));

for i = 1:length(T_vals)
    for j = 1:length(f_vals)
        tic;
        average_accuracies(i, j) = makeMultipleDecisions(D, T_vals(i), f_vals(j), nDecisions, dead_time);
        toc;
    end
end


figure;
hold on;
colors = lines(size(average_accuracies, 2));  % Different colors for each coherence level

for j = 1:size(average_accuracies, 2)
    plot(T_vals * 1000 / 30, average_accuracies(:, j), 'Color', colors(j,:), 'LineWidth', 2);
end

xlabel('Viewing Time (ms)');  % Time in milliseconds
ylabel('Average Accuracy');
title('Model vs. Monkey Data');
legend(arrayfun(@(x) sprintf('%.1f%% Coh', x*100), COH, 'UniformOutput', false));  % Legend for coherence levels
set(gca, 'FontSize', 12);  % Increase font size for readability


load goldShadlen;
hold on;
l2 = plot(dataX, dataY, '.');
set(l2(1), 'color', gold);
set(l2, 'markersize', 10);
hold off;
%The model and data points are well overlaid, showing a clear comparison between simulated and experimental results.


% Extra:
% N is the number of dots moving in the correct direction.
% DT is the total number of overserved dots.
% When N > DT/2, the accuracy is 1.
% P(A) is the probability that accuracy is 1, wihch means N > DT/2.
% Using the cumulative distribution function (CDF) of the binomial distribution:
% P(A) = 1 - CDF_bionomial(DT/2, DT, f).

