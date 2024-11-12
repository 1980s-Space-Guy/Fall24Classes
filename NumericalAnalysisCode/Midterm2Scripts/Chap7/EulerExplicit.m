%% One diff eqs
dy=@(x,y) x*cos(x)+y;
fprime=@(x,y) x*-sin(x)+cos(x)+dy(x,y);

x(1)=0;
y(1)=0.5;

error_y(1)=0;

n=1;
xf=0.05;
dx=(xf-x(1))/n;

for i=1:n
    x(i+1)=x(i)+dx; %#ok<SAGROW>
    y(i+1)=y(i)+dx*dy(x(i),y(i)); %#ok<SAGROW>
    error_y(i+1)=abs(fprime(x(i),y(i))*dx^2/2); %#ok<SAGROW>
end

disp(y)
fprintf('%1.6f\n', error_y(2))

%% System ODE Exercise
L=2;
V1=10;
V2=5;
dC1dt=@(t,C1,C2) -L/V1*C1;
dC2dt=@(t,C1,C2) -L/V2*(C2-C1);
% f1prime=@(x,y1,y2) dy1(x,y1,y2)-2*dy2(x,y1,y2);
% f2prime=@(x,y1,y2) 2*dy1(x,y1,y2)-4*dy2(x,y1,y2);

t(1)=0;
C1(1)=0.3;
C2(1)=0;

% error_y1(1)=0;
% error_y2(1)=0;

n=1;
tf=0.5;
dx=(tf-t(1))/n;

for i=1:n
    t(i+1)=t(i)+dx; %#ok<SAGROW>
    C1(i+1)=C1(i)+dx*dC1dt(t(i),C1(i),C2(i)); %#ok<SAGROW>
    C2(i+1)=C2(i)+dx*dC2dt(t(i),C1(i),C2(i)); %#ok<SAGROW>

    % error_y1(i+1)=abs(f1prime(x(i),y1(i),y2(i))*dx^2/2); %#ok<SAGROW>
    % error_y2(i+1)=abs(f2prime(x(i),y1(i),y2(i))*dx^2/2); %#ok<SAGROW>
end

plot(t, C1); hold on;
plot(t, C2)

%% Explicit Euler with error control (What the built in function does)
% This considers not just error, but stability too
f=@(x,y) -1000*y+x*exp(y);
fprime=@(x,y) -1000*f(x,y)+exp(y)+x*exp(y)*f(x,y);
lambda=@(x,y) f(x,y)/y;

x(1)=0;
y(1)=1;
xf=1;

TOL=1e-6;

for i=1:10000
    if x(i) >= xf
        break
    end
    dx_error=sqrt(TOL*2/abs(fprime(x(i),y(i))));
    dx_stability=2/lambda(x(i),y(i));
    dx=min([dx_error,dx_stability]);
    x(i+1)=x(i)+dx; %#ok<SAGROW>
    y(i+1)=y(i)+dx*f(x(i),y(i)); %#ok<SAGROW>
end

plot(x, y)

%% Error control for Explict Euler
clear;
f1=@(x,y1,y2)y1-2*y2;
f2=@(x,y1,y2)2*y1-4*y2;
dx=0.5;
xi=0; y1_i=0; y2_i=1;
df1=@(x,y1,y2)f1(x,y1,y2)-2*f2(x,y1,y2);
df2=@(x,y1,y2)2*f1(x,y1,y2)-4*f2(x,y1,y2);

error_y1=abs(df1(xi,y1_i,y2_i)/2*dx^2);
error_y2=abs(df2(xi,y1_i,y2_i)/2*dx^2);
TOL=1e-6;

for i=1:2000
    xxx(i)=xi; yyy1(i)=y1_i; yyy2(i)=y2_i;
    dx1=sqrt(TOL*2/abs(df1(xi,y1_i,y2_i)));
    dx2=sqrt(TOL*2/abs(df2(xi,y1_i,y2_i)));
    dx=min([dx1,dx2]);
    x_next=xi+dx;
    y1_next=y1_i+f1(xi,y1_i,y2_i)*dx;
    y2_next=y2_i+f2(xi,y1_i,y2_i)*dx;
    xi=x_next; y1_i=y1_next; y2_i=y2_next;
end
hold on;
plot(xxx,yyy1,'bo')