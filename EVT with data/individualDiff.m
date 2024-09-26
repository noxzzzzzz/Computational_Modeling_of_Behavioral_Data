clear
load riskyChoiceData_2024

meanRiskTaking = mean(rsk,2);

clf; 
plot(BR, meanRiskTaking, '.', 'markersize', 50)
xlabel('blink rate')
ylabel('average risk taking')
set(gca, 'fontsize', 18)
l = lsline;
set(l, 'linewidth', 3, 'color', 'r')


ind = find(~isnan(BR))
[r,p] = corr(BR(ind), meanRiskTaking(ind))
% Given these results, it appears that blink rate, as measured in the 
% dataset, does not have a meaningful or statistically significant linear 
% relationship with risk-taking behavior. This could mean that any observed 
% changes in blink rate are likely due to chance rather than being 
% systematically related to how often individuals choose risky options.
