x=0:0.1:10;

%% First Data
f1=@(x) cos(x);
y1=f1(x);
plot(x,y1);
hold on;

%% Second Data
f2=@(x) sin(x);
y2=f2(x);
plot(x, y2)

%% Display
xlim([0,10])
ylim([-2,2])
xlabel('x', 'FontSize',20)
ylabel('y', 'FontSize',20)
legend('cos(x)', 'sin(x)')
title('Trigonomotry Functions')