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