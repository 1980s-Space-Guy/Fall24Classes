%% Explicit Euler
x(1)=0;
y1(1)=0;
y2(1)=1;

n=20;
xf=10;
dx=(xf-x(1))/n;

for i=1:n
    x(i+1)=x(i)+dx; 
    y1(i+1)=y1(i)+dx*dy1_dx(x(i),y1(i),y2(i)); 
    y2(i+1)=y2(i)+dx*dy2_dx(x(i),y1(i),y2(i)); 
end

plot(x, y1);

%% 2nd order System ODE Exercise
x(1)=0;
y1(1)=0;
y2(1)=1;

n=20;
xf=10;
dx=(xf-x(1))/n;

for i=1:n
    x(i+1)=x(i)+dx; 
    k11=dx*dy1_dx(x(i),y1(i),y2(i));
    k12=dx*dy2_dx(x(i),y1(i),y2(i));

    k21=dx*dy1_dx(x(i)+1/2*dx,y1(i)+1/2*k11,y2(i)+1/2*k12);
    k22=dx*dy2_dx(x(i)+1/2*dx,y1(i)+1/2*k11,y2(i)+1/2*k12);

    y1(i+1)=y1(i)+k21; %#ok<SAGROW>
    y2(i+1)=y2(i)+k22; %#ok<SAGROW>
end

plot(x, y1)

%% Trapezoidal
x(1)=0;
y1(1)=0;
y2(1)=1;

n=20;
xf=10;
dx=(xf-x(1))/n;

for i=1:n
    x(i+1)=x(i)+dx;
    % z(1) is y1 next, z(2) is y2 next
    g1=@(z) y1(i)+0.5*dx*(dy1_dx(x(i),y1(i),y2(i))+dy1_dx(x(i+1),z(1),z(2)))-z(1);
    g2=@(z) y2(i)+0.5*dx*(dy2_dx(x(i),y1(i),y2(i))+dy2_dx(x(i+1),z(1),z(2)))-z(2);
    gg=@(z) [g1(z);g2(z)];

    options=optimset('Display','off');
    y_next_sol=fsolve(gg, [y1(i),y2(i)], options);
    y1(i+1)=y_next_sol(1); %#ok<*SAGROW>
    y2(i+1)=y_next_sol(2);
end

plot(x, y1)

%% ODE Functions
function val=dy1_dx(x,y1,y2)
    val=y1-2*y2;
end

function val=dy2_dx(x,y1,y2)
    if x<1
        val=2*y1-4*y2;
    else
        val=y1-4*y2;
    end
end