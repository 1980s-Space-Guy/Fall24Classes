x0=0;
xf=3;
y0=[0;0];
options=odeset('Stats','on');
soln=ode45(@f,[x0,xf],y0,options);
disp(soln)

function dxdt=f(t,z)
    % z(1) is x, z(2) is dxdt
    dxdt=[z(2);
          sin(10*t)+4*z(1)-5*z(2)];
end