%% Setup
dx=1;
xx=0:dx:6;
f=[0,10,13,15,16,17,18];

i=1;

%% Fowards
fp=(-3*f(i)+4*f(i+1)-f(i+2))/2/dx; %#ok<*NASGU>
fdp=(2*f(i)-5*f(i+1)+4*f(i+2)-f(i+3))/dx^2;

%% Backwards
fp=(3*f(i)-4*f(i-1)+f(i-2))/2/dx;
fdp=(2*f(i)-5*f(i-1)+4*f(i-2)-f(i-3))/dx^2;

%% Central
fp=(f(i+1)-f(i-1))/2/dx;
fdp=(f(i+1)-2*f(i)+f(i-1))/dx^2;

%% Output
fprintf("f' value: %f\n", fp)
fprintf("f'' value: %f\n\n", fdp)