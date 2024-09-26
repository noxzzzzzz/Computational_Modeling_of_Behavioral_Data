clear
load riskyChoiceData_2024

BR'

averageBR = nanmean(BR)
medianBR =nanmedian(BR)
sdBR = nanstd(BR)
maxBR = max(BR)
minBR = min(BR)


clf;
hist(BR, 20)
xlabel('blink rate')
ylabel('number of participants')
set(gca, 'fontsize', 18)