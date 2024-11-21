% Load the data
clear;
load clicks;

% Initialize variables
num_subjects = length(sub);
dn_vals = -20:2:20; % Possible values of dn
all_p_left = []; % Store probabilities for all subjects

% Compute choice curves for each subject
for sn = 1:num_subjects
    clicks = sub(sn).clicks; % Extract clicks data
    choice = sub(sn).choice; % Extract choice data
    
    dn = sum(clicks, 2); % Calculate dn (difference in clicks)
    p_left = nan(1, length(dn_vals));
    
    % Compute probability of choosing left for each dn value
    for i = 1:length(dn_vals)
        ind = dn == dn_vals(i);
        p_left(i) = nanmean(choice(ind));
    end
    
    all_p_left = [all_p_left; p_left]; % Append the results
end

% Plot choice curves for 10 subjects
figure(1);clf;
hold on;
for sn = 1:min(10, num_subjects)
    plot(dn_vals, all_p_left(sn, :), 'DisplayName', ['Subject ' num2str(sn)]);
end
xlabel('Difference in clicks (dn)');
ylabel('Probability of choosing left (p(left))');
title('Choice Curves for 10 Subjects');
legend;
hold off;

% Compute the average choice curve
average_p_left = nanmean(all_p_left, 1);

% Plot the average choice curve and the ideal curve
figure(2);clf;
hold on;
plot(dn_vals, average_p_left, 'b', 'DisplayName', 'Average Human Behavior');
plot(dn_vals, dn_vals >= 0, 'r--', 'DisplayName', 'Pure Click Counting');
xlabel('Difference in clicks (dn)');
ylabel('Probability of choosing left (p(left))');
title('Average Human Behavior vs Pure Click Counting');
legend;
hold off;
