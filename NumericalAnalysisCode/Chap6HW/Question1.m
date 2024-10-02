%% Data
Tp=[-1.6,7.6,15.4,26.1,42.2,60.6]; % Degrees Celsius
VP=[20,40,60,100,200,400]; %% mm Hg
T=25; % Degrees Celsius

%% Part a
slope=(100-60)/(26.1-15.4);
lvp=@(T) slope*(T-15.4)+60;
linear_vp25=lvp(25);

fprintf('Using linear interpolation, the vapor pressure at %2.0f degrees Celsius is: %3.3f mm Hg\n', T, linear_vp25);

%% Part B
A=[1, Tp(3), Tp(3)^2;...
   1, Tp(4), Tp(4)^2;...
   1, Tp(5), Tp(5)^2];

b=[VP(3);VP(4);VP(5)];

qinter_constants=A\b;
a=qinter_constants(1); b=qinter_constants(2); c=qinter_constants(3);

quadratic_vp25=a+b*T+c*T^2;

fprintf('Using quadratic interpolation, the vapor pressure at %2.0f degrees Celsius is: %3.3f mm Hg\n', T, quadratic_vp25);

%% Part C
spline_vp25=spline(Tp,VP,T);
fprintf('Using spline interpolation, the vapor pressure at %2.0f degrees Celsius is: %3.3f mm Hg\n', T, spline_vp25);