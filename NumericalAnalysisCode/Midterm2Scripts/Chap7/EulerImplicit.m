%% Quiz Example
f=@(x,y) x*cos(x)+y;

x(1)=0;
y(1)=0.5;

n=1;
xf=0.05;
dx=(xf-x(1))/n;

for i=1:n
    x(i+1)=x(i)+dx; %#ok<*SAGROW>
    fz=@(yp1) -yp1+y(i)+dx*f(x(i+1),yp1);
    y(i+1)=fzero(fz, y(i), optimset('Display', 'off'));
end

plot(x, y)