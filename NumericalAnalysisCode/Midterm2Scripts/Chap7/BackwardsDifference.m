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
L=2;
V1=10;
V2=5;
dC1dt=@(t,C1,C2) -L/V1*C1;
dC2dt=@(t,C1,C2) -L/V2*(C2-C1);

t(1)=0;
C1(1)=0.3;
C2(1)=0;

n=2;
tf=1;
dt=(tf-t(1))/n;

% trapezoidal Method for first calculation
t(2)=t(1)+dt;
% z(1) is C1 next, z(2) is C2 next
tr1=@(z) C1(1)+0.5*dt*(dC1dt(t(1),C1(1),C2(1))+dC1dt(t(2),z(1),z(2)))-z(1);
tr2=@(z) C2(1)+0.5*dt*(dC2dt(t(1),C1(1),C2(1))+dC2dt(t(2),z(1),z(2)))-z(2);
ttr=@(z) [tr1(z);tr2(z)];

options=optimset('Display','off');
C_next_sol=fsolve(ttr, [C1(1),C2(1)], options);
C1(2)=C_next_sol(1);
C2(2)=C_next_sol(2);

% Backwards Difference for the rest
for i=2:n
    t(i+1)=t(i)+dt;
    % z(1) is C1 next, z(2) is C2 next
    bd1=@(z) -1/3*C1(i-1)+4/3*C1(i)+2*dt/3*dC1dt(t(i+1),z(1),z(2))-z(1);
    bd2=@(z) -1/3*C2(i-1)+4/3*C2(i)+2*dt/3*dC2dt(t(i+1),z(1),z(2))-z(2);
    bbd=@(z) [bd1(z);bd2(z)];

    C_next_sol=fsolve(bbd,[C1(i),C2(i)],options);
    C1(i+1)=C_next_sol(1);
    C2(i+1)=C_next_sol(2);
end

disp(C1)
disp(C2)