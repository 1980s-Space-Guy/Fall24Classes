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