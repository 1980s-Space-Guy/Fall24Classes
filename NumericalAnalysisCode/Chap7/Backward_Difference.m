%% Quiz Problem
f=@(x,y) x*cos(x)+y;

% Initail Condition
x(1)=0;
y(1)=0.5;

step=0.05;
xf=0.1;
n=(xf-x(1))/step;

% Using Trapezoidal method to find next y value
x(2)=x(1)+step;
ft=@(yp1) -yp1+y+step*0.5*(f(x(1),y(1))+f(x(2),yp1));
y(2)=fzero(ft,y(1),optimset('Display', 'off'));

% Using Backwards Difference for the remainder of the steps
for i=2:n
    x(i+1)=x(i)+step;
    fbd=@(yp1) -yp1-1/3*y(i-1)+4/3*y(i)+2*step/3*f(x(i+1),yp1);
    y(i+1)=fzero(fbd,y(i),optimset('Display','off'));
end

disp(y)

%% System of ODE exercise