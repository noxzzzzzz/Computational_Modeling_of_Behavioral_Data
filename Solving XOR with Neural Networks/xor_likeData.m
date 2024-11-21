clear
 
n_train = 100;
[x_train, c_train] = make_dataset_v1(n_train);
 
figure(1); clf;
i1 = c_train == 1;
i0 = c_train == 0;
hold on;
l = plot(x_train(i0,2), x_train(i0,1), 'o');
l(2) = plot(x_train(i1,2), x_train(i1,1), 'v');
set(l, 'markerfacecolor', 'w', 'linewidth', 2, 'markersize', 10)
set(gca, 'tickdir', 'out', 'fontsize', 24)
xlabel('x1')
ylabel('x2')