f=@(x,y) x*cos(x)+y;

x=0;
y=0.5;
step=0.05;
xf=0.05;

for i=x:step:xf-step
    y=y+f(i,y)*step;
end

disp(y)