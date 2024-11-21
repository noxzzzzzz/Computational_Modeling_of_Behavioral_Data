clear
load riskyChoiceData_2024
whos
QUS'

for i = 1:length(P)
    EV_risky(i) = P(i) * V(i);
end

EV_risky'

clf;
plot(EV_risky, '.', 'markersize', 50)
xlabel('question number')
ylabel('EV_risky', 'interpreter', 'none')
set(gca, 'fontsize', 18)

imagesc(rsk)
xlabel('question number')
ylabel('participant number')
set(gca, 'fontsize', 18)
