%% Quiz Problem
x0=[0,0];
tspan=[0,3];
options=optimset('Display','off');
soln=ode45(@odefuncq,tspan,x0,options);
disp(deval(soln,3,1))

function ode=odefuncq(t,z)
    % z(1) is x, z(2) is dxdt
    ode(1,1)=z(2);
    ode(2,1)=sin(10*t)-5*z(2)+4*z(1); 
end

%% Practice 1 (Piecewise)
x0=[0,1];
tspan=[0,3];
options=optimset('Display','off');
soln=ode45(@odefunci,tspan,x0,options);
disp(deval(soln,3,1))

function ode=odefunci(t,z)
    % z(1) is x, z(2) is dxdt
    ode(1,1)=z(2);
    if t<1
        c=1;
    elseif t<2
        c=20;
    else
        c=3;
    end
    ode(2,1)=c+z(1);
end

%% Practice 2 (Higher Order)
x0=[1,0,1,0];
tspan=[0,1];
options=optimset('Display','off');
soln=ode45(@odefuncc,tspan,x0,options);
disp(deval(soln,1,1))
disp(deval(soln,1,3))

function ode=odefuncc(t,z)
    % z(1) is C, z(2) is C', z(3) is T, z(4) is T'
    ode(1,1)=z(2);
    ode(2,1)=5-z(1)^2-z(1)*z(2);
    ode(3,1)=z(4);
    ode(4,1)=t^2+2-z(3)*z(1);
end

%% Practice 3 (fzero)
x0=[6,0];
tspan=[0,3];
options=optimset('Display','off');
soln=ode45(@odefuncg,tspan,x0,options);
fzerofuncg=@(t) deval(soln,t,1);

tt=linspace(0,1,50);
yy=deval(soln,tt,1);
%plot(tt,yy)
gound_hit_time=fzero(fzerofuncg,[0.3,0.7],options);
disp(gound_hit_time)
gound_hit_speed=deval(soln,gound_hit_time,2);
disp(gound_hit_speed)

function ode=odefuncg(t,z)
    % z(1) is y, z(2) is dydt
    ode(1,1)=z(2); % dxdt
    ode(2,1)=-32+0.05*z(2)^2;
end