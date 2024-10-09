f=@(x,y) x*cos(x)+y;

x=0;
y=0.5;
step=0.05;
xf=0.05;

for i=x:step:xf-step
    fz=@(yp1) -yp1+y+step*f(i+step,yp1);
    yp1=fzero(fz, y, optimset('Display', 'off'));
    y=yp1;
end

disp(yp1)