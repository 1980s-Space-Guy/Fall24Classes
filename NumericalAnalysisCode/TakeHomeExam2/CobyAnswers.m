%% Atmospheric Data %%
temperature_array = [21.5,15,8.5,2,-4.49,-10.98,-17.47,-23.96,-30.45,-36.94,-43.42,-49.9,-56.5,-56.5,-51.6,-46.64,-22.8,-2.5,26.13,-53.57,-74.51,];
pressure_array = [11.39,10.13,8.988,7.95,7.012,6.166,5.405,4.722,4.111,3.565,3.08,2.65,1.211,0.5529,0.2549,0.1197,0.0287,0.007978,0.002196,0.00052,0.00011];

%% --- Part (a) --- %%
density_iron = 7860; %kg/m3
radius_iron = 0.05; %m
h_init_1000 = 1000; %m
h_final_1000 = 0; %m

A_iron = pi * radius_iron^2; %m2

mass_iron = (4/3) * density_iron * pi * radius_iron^3; %kg

dydt_1 = @(t,y) freefall_ode(t,y, A_iron, mass_iron, radius_iron);

% Solve ODE
y0 = [h_init_1000, 0];
tspan = [0, 20];
opts = odeset('AbsTol', 1e-9);
soln = ode45(dydt_1, tspan, y0, opts);

% Evaluate the solution
t = linspace(tspan(1), tspan(2), 10000);
y = deval(soln, t);

% Find the time and velocity at sea level
idx = find(y(1, :) <= 0, 1);
time_1000_iron = t(idx);
vel_1000_iron = y(2, idx);

t = t(1:idx);

% Plot altitude and velocity
figure;
plot(t, y(1, 1:idx)), xlabel('Time (s)'), ylabel('Altitude (m)');
grid on;
title('(a) Altitude vs. Time for Freefall');

figure;
plot(t, y(2, 1:idx)), xlabel('Time (s)'), ylabel('Velocity (m/s)');
grid on;
title('(a) Velocity vs. Time for Freefall');

step_size = 1;

h_array = h_final_1000:step_size:h_init_1000;
g_array = grav(h_array);
U_1000_iron = mass_iron * step_size * sum(g_array);

K_1000_iron = (1/2) * mass_iron * vel_1000_iron;
H_1000_iron = - K_1000_iron - U_1000_iron;

fprintf("--- Part (A) ---\n")
fprintf("The time to reach sea level is %4.5f seconds\n",time_1000_iron)
fprintf("The speed at sea level is %4.5f m/s\n",vel_1000_iron)
fprintf("The thermal energy generated is %4.5f J\n",-1 * H_1000_iron)

%% --- Part (b) --- %%
h_init_2000 = 2000; %m
h_final_2000 = 0; %m

dydt_2 = @(t,y) freefall_ode(t,y, A_iron, mass_iron, radius_iron);

% Solve ODE
y0 = [h_init_2000, 0];
tspan = [0, 40];
opts = odeset('AbsTol', 1e-9);
soln = ode45(dydt_2, tspan, y0, opts);

% Evaluate the solution
t = linspace(tspan(1), tspan(2), 10000);
y = deval(soln, t);

% Find the time and velocity at sea level
idx = find(y(1, :) <= 0, 1);
time_2000_iron = t(idx);
vel_2000_iron = y(2, idx);

t = t(1:idx);

% Plot altitude and velocity
figure;
plot(t, y(1, 1:idx)), xlabel('Time (s)'), ylabel('Altitude (m)');
grid on;
title('(b) Altitude vs. Time for Freefall');

figure;
plot(t, y(2, 1:idx)), xlabel('Time (s)'), ylabel('Velocity (m/s)');
grid on;
title('(b) Velocity vs. Time for Freefall');

step_size = 1;

h_array = h_final_2000:step_size:h_init_2000;
g_array = grav(h_array);
U_2000_iron = -(mass_iron * step_size * sum(g_array));

K_2000_iron = (1/2) * mass_iron * vel_2000_iron;
H_2000_iron = - K_2000_iron - U_2000_iron;

fprintf("--- Part (B) ---\n")
fprintf("The time to reach sea level is %4.5f seconds\n",time_2000_iron)
fprintf("The speed at sea level is %4.5f m/s\n",vel_2000_iron)
fprintf("The energy from fricion lost is %4.5f J\n",H_2000_iron)
fprintf("The thermal energy generated is %4.5f J\n",-1 * H_2000_iron)

%% --- Part (c) --- %%
density_glass = 2500; %kg/m3
radius_glass = 0.05; %m

A_glass = pi * radius_glass^2; %m2

mass_glass = (4/3) * density_glass * pi * radius_glass^3; %kg

h_init_2000_g = 2000; %m
h_final_2000_g = 0; %m

dydt_3 = @(t,y) freefall_ode(t,y, A_glass, mass_glass, radius_glass);

% Solve ODE
y0 = [h_init_2000_g, 0];
tspan = [0, 40];
opts = odeset('AbsTol', 1e-9);
soln = ode45(dydt_3, tspan, y0, opts);

% Evaluate the solution
t = linspace(tspan(1), tspan(2), 10000);
y = deval(soln, t);

% Find the time and velocity at sea level
idx = find(y(1, :) <= 0, 1);
time_2000_glass = t(idx);
vel_2000_glass = y(2, idx);

t = t(1:idx);

% Plot altitude and velocity
figure;
plot(t, y(1, 1:idx)), xlabel('Time (s)'), ylabel('Altitude (m)');
grid on;
title('(c) Altitude vs. Time for Freefall');

figure;
plot(t, y(2, 1:idx)), xlabel('Time (s)'), ylabel('Velocity (m/s)');
grid on;
title('(c) Velocity vs. Time for Freefall');

step_size = 1;

h_array = h_final_2000_g:step_size:h_init_2000_g;
g_array = grav(h_array);
U_2000_glass = mass_glass * step_size * sum(g_array);

K_2000_glass = (1/2) * mass_glass * vel_2000_glass;
H_2000_glass = - K_2000_glass - U_2000_glass;

fprintf("--- Part (C) ---\n")
fprintf("The time to reach sea level is %4.5f seconds\n",time_2000_glass)
fprintf("The speed at sea level is %4.5f m/s\n",vel_2000_glass)
fprintf("The energy from fricion lost is %4.5f J\n",H_2000_glass)
fprintf("The thermal energy generated is %4.5f J\n",-1 * H_2000_glass)

function f = mu_air(h)
    altitude_array = [-1000,0,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,15000,20000,25000,30000,40000,50000,60000,70000,80000];
    viscosity_array = [1.821,1.789,1.758,1.726,1.694,1.661,1.628,1.595,1.561,1.527,1.493,1.458,1.422,1.422,1.448,1.475,1.601,1.704,1.584,1.438,1.321];
    f = spline(altitude_array, viscosity_array, h) / 10^5;
end

function f = rho_air(h)
    altitude_array = [-1000,0,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,15000,20000,25000,30000,40000,50000,60000,70000,80000];
    density_array = [1.347,1.225,1.112,1.007,0.9093,0.8194,0.7364,0.6601,0.59,0.5258,0.4671,0.4135,0.1948,0.08891,0.04008,0.01841,0.003996,0.001027,0.0003097,0.00008283,0.00001846];
    f = spline(altitude_array, density_array, h);
end

function f = grav(h)
    altitude_array = [-1000,0,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,15000,20000,25000,30000,40000,50000,60000,70000,80000];
    gravity_array = [9.81,9.807,9.804,9.801,9.797,9.794,9.791,9.788,9.785,9.782,9.779,9.776,9.761,9.745,9.73,9.715,9.684,9.654,9.624,9.594,9.564,];
    f = spline(altitude_array, gravity_array, h);
end

function cd = drag_coeff(rho, v, r, mu)
    Re = abs(rho * v * 2 * r / mu);
    if Re < 10^(-4)
        cd = 240000;
    elseif Re < 0.2
        cd = 24 / Re;
    elseif Re < 1000
        cd = (24/Re) * (1 + 0.14 * Re^0.7);
    elseif Re < 2*10^3
        cd = (21.12 / Re) + (6.3*Re^(-0.5)) + 0.25;
    else
        Cd0 = (21.12 / Re) + (6.3*Re^(-0.5)) + 0.25;
        Ma = abs(v) / 343;
        cd = Cd0 * (1-0.445 * Ma + 4.84 * Ma^2 - 9.73* Ma^3 + 6.93 * Ma^4)/(sqrt(1 + 1.2*Ma*Cd0));
    end
end

function dydt = freefall_ode(t,y, A, mass, r)
    dydt = zeros(2,1);
    if y(1) <= 0
        dydt(1) = 0; % Altitude stops changing
        dydt(2) = 0; % Velocity stops changing
    else
        g = grav(y(1));
        rho = rho_air(y(1));
        mu = mu_air(y(1));
        Cd = drag_coeff(rho, y(2), r, mu);
        drag_force = 0.5 * rho * A * y(2)^2 * Cd / mass;
        dydt(1) = y(2);
        dydt(2) = -g + drag_force;
    end
end