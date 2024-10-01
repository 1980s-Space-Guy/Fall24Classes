% Your function
f=@(x,y) x*cos(x)+y;

% xi is initial x, y is inital y
xi=0;
y=0.5;
step=0.05;
xf=0.05;

for x=xi:step:xf-step
    k1=f(x,y);
    k2=f(x+step/2,y+step*k1/2);
    k3=f(x+step/2,y+step*k2/2);
    k4=f(x+step,y+k3*step);
    y=y+step/6*(k1+2*k2+2*k3+k4);
end

fprintf('%3.5f\n', y)