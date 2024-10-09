f=@(x,y) x*cos(x)+y;
fprime=@(x,y) cos(x)-x*sin(x)+f(x,y);

x(1)=0;
y(1)=0.5;

error(1)=0;

n=1;
xf=0.05;
step=(xf-x(1))/n;

for i=1:n
    x(i+1)=x(i)+step; %#ok<SAGROW>
    y(i+1)=y(i)+step*f(x(i),y(i)); %#ok<SAGROW>
    error(i+1)=fprime(x(i), y(i))*step^2/2; %#ok<SAGROW>
end

disp(y)
fprintf('%1.6f\n', error(2))
%% Explicit Euler with error control (What the built in function does)
f=@(x,y) x*cos(x)+y;
fprime=@(x,y) cos(x)-x*sin(x)+f(x,y);

x(1)=0;
y(1)=0.5;

TOL=1e-6;

for i=1:10000
    if x(i) > 1
        break
    end
    dx=sqrt(TOL*2/abs(fprime(x(i),y(i))));
    x(i+1)=x(i)+dx; %#ok<SAGROW>
    y(i+1)=y(i)+dx*f(x(i),y(i)); %#ok<SAGROW>
end

disp(y)