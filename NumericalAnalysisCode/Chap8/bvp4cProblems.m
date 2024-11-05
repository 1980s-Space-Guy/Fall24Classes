%% Quiz Problem
quiz_problem()
function quiz_problem
xx=linspace(0,1,50);
solninit=bvpinit(xx,@funinit);
soln=bvp4c(@odefun,@funbc,solninit);
yy=deval(soln,xx);
plot(xx,yy)

    function dydx=odefun(x,y)
        dydx(1,1)=y(2);
        dydx(2,1)=-exp(y(1));
    end

    function residual=funbc(ya,yb)
        residual(1,1)=ya(1); % y at 0 is 0
        residual(2,1)=yb(1); % y at 1 is 0
    end
    
    function yinit=funinit(x)
        % Guess that y = 0 and y' = 1
        yinit=[0,1];
    end
end

%% Class example
in_class_example()
function in_class_example
tt=linspace(0,1,50); % boundaries are t=0 and t=1
solninit=bvpinit(tt,@funinit);
soln=bvp4c(@odefun,@funbc,solninit);
CC=deval(soln,tt,1);
TT=deval(soln,tt,3);
plot(tt,CC); hold on;
plot(tt,TT)
legend('Concentration','Temperature')

    function dydx=odefun(t,y)
        % y(1) is C, y(2) is C', y(3) is T
        dydx(1,1)=y(2);
        dydx(2,1)=t-5*y(1)-2*y(1)*y(2);
        dydx(3,1)=(5-y(3)^2)/y(1);
    end

    function residual=funbc(ya,yb)
        residual(1,1)=ya(1)-1; % C at 0 is 1
        residual(2,1)=ya(2)-1; % C' at 0 is 1
        residual(3,1)=yb(3)-1.5; % T at 1 is 1.5
    end
    
    function yinit=funinit(t)
        % Guess that C = 1, C' = 1 and T = 1
        yinit=[1,1,1];
    end
end