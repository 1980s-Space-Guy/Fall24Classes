f=@(x,y) x*cos(x)+y;

x(1)=0;
y(1)=0.5;
n=1;
xf=0.05;
dx=(xf-x(1))/n;

for i=1:n
    x(i+1)=x(i)+dx;
    fz=@(yp1) -yp1+y(i)+dx*0.5*(f(x(i),y(i))+f(x(i+1),yp1));
    y(i+1)=fzero(fz,y(i),optimset('Display', 'off'));
end

disp(y)

%% Trapezoidal System of ODEs
f1=@(x,y1,y2) y1-2*y2;
f2=@(x,y1,y2) 2*y1-4*y2;

x(1)=0;
y1(1)=0;
y2(1)=1;

n=200;
xf=9;
dx=(xf-x(1))/n;

for i=1:n
    x(i+1)=x(i)+dx; %#ok<SAGROW>
    % z(1) is y1 next, z(2) is y2 next
    g1=@(z) y1(i)+0.5*dx*(f1(x(i),y1(i),y2(i))+f1(x(i+1),z(1),z(2)))-z(1);
    g2=@(z) y2(i)+0.5*dx*(f2(x(i),y1(i),y2(i))+f2(x(i+1),z(1),z(2)))-z(2);
    gg=@(z) [g1(z);g2(z)];

    options=optimset('Display','off');
    y_next_sol=fsolve(gg, [y1(i),y2(i)], options);
    y1(i+1)=y_next_sol(1); %#ok<SAGROW>
    y2(i+1)=y_next_sol(2); %#ok<SAGROW>
end

plot(x, y1); hold on;
plot(x, y2)