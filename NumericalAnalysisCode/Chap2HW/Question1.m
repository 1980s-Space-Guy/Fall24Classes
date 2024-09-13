%% Part 1

% Values are for water at 25 degrees celsius
viscosity = 0.00089; % Pa*s or kg/m*s
density = 997; % kg/m3
diameter = 0.5; % m

%% Part 2

x_values = 0.001:0.05:1;
y_values = zeros(1, length(x_values));

for i = 1:length(x_values)
    y_values(i) = friction_factor(reynolds_number(density, x_values(i),...
        viscosity, diameter));
end

friction_factor_data = plot(x_values, y_values);
set(friction_factor_data, 'Color', [0, 0, 1])
xlim([0.001, 0.951])
ylim([0, 0.03])
xlabel('Flow Velocity (m/s)')
ylabel('Friction Factor (Dimensionless)')
title('Question 1 Graph')
