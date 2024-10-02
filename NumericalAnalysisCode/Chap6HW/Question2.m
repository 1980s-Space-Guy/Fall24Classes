%% Initializing Data
PS=[10,15,20,25,30,35];
IoR=[1.3479,1.3557,1.3639,1.3723,1.3811,1.3902];

Sol_PS=spline(IoR,PS,1.3606);

fprintf('At an index of refraction of 1.3606, the composition is %2.2f percent sucrose\n', Sol_PS)