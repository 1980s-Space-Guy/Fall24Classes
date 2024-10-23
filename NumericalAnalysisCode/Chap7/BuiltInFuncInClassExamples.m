t0=0;
tf=3;
x0=[0;1];
soln=ode45(@insert_func_name_here,[t0,tf],x0);
tt=linspace(0,3,100);
xx=deval(soln,tt,1);
plot(tt, xx)

function ode=insert_func_name_here(t,w)
    % w(1) is x, w(2) is x prime
    ode(1,1)=w(2);
    if t>=0 && t<1
        c=1;
    elseif t<2
        c=20;
    else
        c=3;
    end
    ode(2,1)=c+w(1);
end

%% Example 2:
% y(1) is C, y(2) is C', y(3) is T

y0 = [1;1;1];
t0=0;
tf=1;
soln=ode45(@goofy_function,[t0,tf],y0);
tt=linspace(0,1,100);
CC=deval(soln,tt,1);
TT=deval(soln,tt,3);
figure, plot(tt, CC);
figure, plot(tt, TT);


function ode=goofy_function(t, y)
    ode(1,1)=y(2);
    ode(2,1)=t-5*y(1)-2*y(1)*y(2);
    ode(3,1)=(5-y(3)^2)/y(1);
end

%% Example 3
hit_ground_time=fzero(@ground_funtion,[0,2]);
disp(hit_ground_time)

function pos=ground_funtion(time)
    soln=ode45(@silly_function,[0,2],[5,0]);
    pos=deval(soln,time,1);

    function dydt=silly_function(t,y)
        % y(1) is position, y(2) is velocity
        dydt(1,1)=y(2);
        dydt(2,1)=-32+0.01*y(2)^2;
    end
end