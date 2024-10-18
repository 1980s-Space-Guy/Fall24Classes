%% One diff eqs
dy=@(x,y) -1000*y+x*exp(y);
%f1prime=@(x,y1,y2) dy1(x,y1,y2)-2*dy2(x,y1,y2);

x(1)=0;
y(1)=1;

error_y(1)=0;

n=5;
xf=0.1;
dx=(xf-x(1))/n;

for i=1:n
    x(i+1)=x(i)+dx; %#ok<SAGROW>
    y(i+1)=y(i)+dx*dy(x(i),y(i)); %#ok<SAGROW>
    %error_y1(i+1)=abs(fprime(x(i),y(i))*dx^2/2); %#ok<SAGROW>
end

disp(y)

%% Two diff eqs
dy1=@(x,y1,y2) y1-2*y2;
dy2=@(x,y1,y2) 2*y1-4*y2;
f1prime=@(x,y1,y2) dy1(x,y1,y2)-2*dy2(x,y1,y2);
f2prime=@(x,y1,y2) 2*dy1(x,y1,y2)-4*dy2(x,y1,y2);

x(1)=0;
y1(1)=0;
y2(1)=1;

error_y1(1)=0;
error_y2(1)=0;

n=100;
xf=0.5;
dx=(xf-x(1))/n;

for i=1:n
    x(i+1)=x(i)+dx; %#ok<SAGROW>
    y1(i+1)=y1(i)+dx*dy1(x(i),y1(i),y2(i)); %#ok<SAGROW>
    y2(i+1)=y2(i)+dx*dy2(x(i),y1(i),y2(i)); %#ok<SAGROW>

    error_y1(i+1)=abs(f1prime(x(i),y1(i),y2(i))*dx^2/2); %#ok<SAGROW>
    error_y2(i+1)=abs(f2prime(x(i),y1(i),y2(i))*dx^2/2); %#ok<SAGROW>
end

plot(x, y1); hold on;
plot(x, y2)
%% Explicit Euler with error control (What the built in function does)
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