%% Problem 1
problem1()
function problem1
    x_span=[0,4];
    n=81;
    dx=(x_span(2)-x_span(1))/n;
    xx=linspace(x_span(1),x_span(2),n);
    initial_guess=zeros(n,1); % Ok because system is linear
    options=optimset('Display','off');
    soln=fsolve(@bvp,initial_guess,options);
    plot(xx,soln);

    function f=bvp(y)
        f(1,1)=y(1);
        for i=2:n-1
            f(i,1)=(y(i+1)-2*y(i)+y(i-1))/dx^2+abs(y(i));
        end
        f(n,1)=y(n)+1;
    end
end

%% Problem 2
problem2()
function problem2
    x_span=[0,4];
    n=41;
    dx=(x_span(2)-x_span(1))/n;
    xx=linspace(x_span(1),x_span(2),n);
    initial_guess=zeros(n,1); % Ok because system is linear
    options=optimset('Display','off');
    soln=fsolve(@bvp,initial_guess,options);
    plot(xx,soln);

    function f=bvp(y)
        f(1,1)=1/2/dx*(-3*y(1)+4*y(2)-y(3));
        for i=2:n-1
            f(i,1)=(y(i+1)-2*y(i)+y(i-1))/dx^2+abs(y(i));
        end
        f(n,1)=1/2/dx*(3*y(n)-4*y(n-1)+y(n-2))-1;
    end
end