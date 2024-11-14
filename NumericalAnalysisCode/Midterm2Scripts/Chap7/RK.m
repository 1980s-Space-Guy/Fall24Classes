%% 2nd order System ODE Exercise
y1p=@(x,y1,y2) -y1^2+y2;
y2p=@(x,y1,y2) y1-4*y2^2;

x(1)=0;
y1(1)=2;
y2(1)=2;

n=1;
xf=0.1;
dx=(xf-x(1))/n;

for i=1:n
    x(i+1)=x(i)+dx; %#ok<SAGROW>
    k11=dx*y1p(x(i),y1(i),y2(i));
    k12=dx*y2p(x(i),y1(i),y2(i));

    k21=dx*y1p(x(i)+1/2*dx,y1(i)+1/2*k11,y2(i)+1/2*k12);
    k22=dx*y2p(x(i)+1/2*dx,y1(i)+1/2*k11,y2(i)+1/2*k12);

    y1(i+1)=y1(i)+k21; %#ok<SAGROW>
    y2(i+1)=y2(i)+k22; %#ok<SAGROW>
end

disp(y1)
disp(y2)

%% Fourth order Quiz
f=@(x,y) x*cos(x)+y;

% xi is initial x, y is inital y
xi=0;
y=0.5;
dx=0.05;
xf=0.05;

for x=xi:dx:xf-dx
    k1=f(x,y);
    k2=f(x+dx/2,y+dx*k1/2);
    k3=f(x+dx/2,y+dx*k2/2);
    k4=f(x+dx,y+k3*dx);
    y=y+dx/6*(k1+2*k2+2*k3+k4);
end

fprintf('%3.5f\n', y)