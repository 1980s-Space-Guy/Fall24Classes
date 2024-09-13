%% making data and graph
x_values = 0:0.02:3.14;
y_values = sin(x_values);

disp(y_values)

sin_line = plot(x_values, y_values);

%% adding labels
xlabel('x values')
ylabel('y values')
title('y = sin(x)')