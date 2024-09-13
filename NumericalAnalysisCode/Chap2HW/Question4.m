x_values = 0:0.02:3.14;
sin_values = sin(x_values);
cos_values = cos(x_values);

sin_line = plot(x_values, sin_values);
hold on;
cos_line = plot(x_values, cos_values);

xlim([0, 3.14])

xlabel('x values')
ylabel('y values')
title('y = sin(x) and y = cos(x)')
legend('y = sin(x)', 'y = cos(x)')