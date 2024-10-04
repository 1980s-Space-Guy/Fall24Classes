%%
fprintf("--- Part (A) ---\n")

% Define constants from the problem
Q = 2.5; %L / sec
L = 15; %m
P_max = 103000; %Pa
T = 25 + 273.15; % K;

function pressure = delta_P(D,T,Q,L)
vel =@(D) 4*Q / (pi()*D^2*1000); %D [=] m; returns m/s
rho =@(T) 46.048 + T*(9.418+T*(-0.0329+T*((4.882*10^(-5) - (2.895*10^(-8)*T))))); %T [=] K; returns kg/m3
mu =@(T) exp(-10.547 + 541.69/(T-144.53)); %T [=] K; returns Pa S
Re =@(D,v,p,u) D*v*p/u; %inputs in SI units; returns dimensionless

v = vel(D);
p = rho(T);
u = mu(T);
Reynold = Re(D,v,p,u);
f = 16 / Reynold;
    
if Reynold  > 2100
    f_turb =@(x) ((4*log10(Reynold*sqrt(x))-0.4)^2)^(-1) - x;
    f = fzero(f_turb,[f,1]);
end
pressure = 2*f*p*L*v^2/D; %inputs in SI; output is Pa
end

% Initial guesses where P_1, P_2 have different signs to allow us to use
% the bisection method
D_guess_1 = 0.000005;
D_guess_2 = 0.5;
    
% Since this is computationally quick, we can enforce a very stringent
% tolerance
tolerance = 0.99999999;

% Loop until tolerance * P_max < P < P_max/tolerance
while (P_max*tolerance > P_guess_1) ||  (P_guess_1 > P_max/tolerance)
    % Calculate the pressure at our endpoints
    P_guess_1 = delta_P(D_guess_1, T,Q,L);
    P_guess_2 = delta_P(D_guess_2, T,Q,L);

    % Check if above or below P_max
    delta_P_1 = P_max - P_guess_1;
    delta_P_2 = P_max - P_guess_2;

    % New guess is the midpoint between the two bounds
    D_guess_mid = (D_guess_1 + D_guess_2)/2;
    P_guess_mid = delta_P(D_guess_mid, T,Q,L);
    delta_P_mid = P_max - P_guess_mid;
    
    % If P_mid has a different sign than P_1, replace P_2 with P_mid
    if delta_P_1 * delta_P_mid < 0
        D_guess_2 = D_guess_mid;
    % If P_mid has a different sign than P_2, replace P_1 with P_mid
    else
        D_guess_1 = D_guess_mid;
    end
end
% Define variables with our answer and print
D_final = D_guess_1;
P_final = P_guess_1;
fprintf("The final diameter is %4.6f meters, which results in a pressure drop of %4.2f Pa\n", D_final, P_final)

%%
fprintf("--- Part (B) ---\n")

% Imported values from the given table
nom_size = ["1/8","1/4","3/8","1/2","3/4","1","1-1/4","1-1/2","2","2-1/2","3","3-1/2","4","5","6","8","10","12"];
OD_inch = [0.405,0.540,0.675,0.840,1.050,1.315,1.660,1.9,2.375,2.875,3.5,4,4.5,5.563,6.625,8.625,10.75,12.75];
wall_diam_inch = [0.068,0.088,0.091,0.109,0.113,0.133,0.140,0.145,0.154,0.203,0.216,0.226,0.237,0.258,0.280,0.322,0.365,0.375];

% ID = OD - 2 * wall thickness
ID_inch = OD_inch - 2*wall_diam_inch;

% Convert the array to meters to use our functions
ID_meter = ID_inch/39.3701;

% Loop through the array and calculate delta P at each point
for i=1:length(ID_meter)
    ID = ID_meter(i);
    P = delta_P(ID,T,Q,L);
    % Since pressure decreases as diameter increase, we break at the first
    % diameter where P < P_max
    if P < P_max
        break
    end
end

% Define permanent variables and print
ID_ideal = ID;
fprintf("The optimal nominal diameter is %s inches, which has a pressure drop of %4.2f Pa\n", nom_size(i),P);

%%
fprintf("--- Part (C) ---\n")

% Set temperature range from problem
T_min = 5 + 273.15;
T_max = 80 + 273.15;

% Create array with lots of points between T_min and T_max
T_range = T_min:0.01:T_max;

% Constants from the problem statement
Q = 5; %L/s
L = 16; % meters
ID = ID_meter(7); %1-1/4 inch

% Create an empty array to add our pressure values at each temperature to
P_drop_range = zeros(length(T_range),1);

% Loop through all of the temperatures and calculate presure
for j=1:length(T_range)
    T = T_range(j);
    P = delta_P(ID,T,Q,L);
    P_drop_range(j) = P;
end

% Find minimum and maximum values, along with their index
[P_drop_min, j_min] = min(P_drop_range);
[P_drop_max, j_max] = max(P_drop_range);

% Print results
fprintf("The minimum pressure drop is %4.2f Pa, achieved at %4.2f °C\n", P_drop_min, T_range(j_min)-273.15)
fprintf("The maximum pressure drop is %4.2f Pa, achieved at %4.2f °C\n", P_drop_max, T_range(j_max)-273.15)

%%
fprintf("--- Part (D) ---\n")

% Find the closest value to P_max
[n, k] = min(abs(P_drop_range - P_max));

% If the pressure is greater than P_max, increase the index by 1 to get a
% value less than P_max
if P_drop_range(k) > P_max
    k = k+1;
end

% Define variables with the answers and print results
min_T = T_range(k) - 273.15;
min_P = P_drop_range(k);

fprintf("The minimum operating temperature is %4.2f °C, where the pressure drop is %4.2f Pa\n",min_T,min_P)
