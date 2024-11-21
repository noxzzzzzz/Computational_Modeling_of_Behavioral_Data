load data
Q0 = 0;  % Initial Q-value
sn = 1;  % Subject number

% Choices and outcomes
choice = sub(sn).response1;
r = sub(sn).outcome1;

[Xfit, nLL_best] = fit_simpleRL_new(choice, r, Q0);

numSubjects = length(sub);
Xfit1 = zeros(numSubjects, 2);  % To store parameters for session 1
nLL_best1 = zeros(numSubjects, 1);  % To store negative log likelihoods

Xfit2 = zeros(numSubjects, 2);  % To store parameters for session 2
nLL_best2 = zeros(numSubjects, 1);

for sn = 1:numSubjects
    % Session 1
    choice1 = sub(sn).response1;
    r1 = sub(sn).outcome1;
    [Xfit1(sn,:), nLL_best1(sn)] = fit_simpleRL_new(choice1, r1, Q0);
    
    % Session 2
    choice2 = sub(sn).response2;
    r2 = sub(sn).outcome2;
    [Xfit2(sn,:), nLL_best2(sn)] = fit_simpleRL_new(choice2, r2, Q0);
end

clf;

% Learning Rate Alpha - Session 1
subplot(2,2,1);
histogram(Xfit1(:,1), 'BinWidth', 0.05);
xlabel('Learning Rate (\alpha)');
ylabel('Number of Participants');
title('Session 1');

% Learning Rate Alpha - Session 2
subplot(2,2,2);
histogram(Xfit2(:,1), 'BinWidth', 0.05);
xlabel('Learning Rate (\alpha)');
ylabel('Number of Participants');
title('Session 2');

% Softmax Parameter Beta - Session 1
subplot(2,2,3);
histogram(log(Xfit1(:,2)), 'BinWidth', 0.2);
xlabel('log(Softmax Parameter \beta)');
ylabel('Number of Participants');

% Softmax Parameter Beta - Session 2
subplot(2,2,4);
histogram(log(Xfit2(:,2)), 'BinWidth', 0.2);
xlabel('log(Softmax Parameter \beta)');
ylabel('Number of Participants');


