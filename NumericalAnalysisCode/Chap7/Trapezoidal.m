f=@(x,y) x*cos(x)+y;

x=0;
y=0.5;
n=1;
xf=0.05;
step=(xf-x)/n;

for i=x:step:xf-step
    fz=@(yp1) -yp1+y+step*0.5*(f(i,y)+f(i+step,yp1));
    yp1=fzero(fz,y,optimset('Display', 'off'));
    y=yp1;
end

fprintf('%1.5f\n',y)