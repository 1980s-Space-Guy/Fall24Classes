RandomProblem()
function RandomProblem
    xx=linspace(0,1,50);
    solninit=bvpinit(xx,@funinit);
    soln=bvp4c(@odefun,@funbc,solninit);
    yy=deval(soln,xx,1);
    fprintf('Y at x=l: %1.3f\n', yy(end))
    plot(xx,yy)

    % ODE function
    function dydx=odefun(x,y) %#ok<INUSD>
        dydx(1,1)=y(2);
        dydx(2,1)=5*y(1);
    end

    % Boundary conditions
    function residual=funbc(ya,yb)
        residual(1,1)=ya(1)-1; % y at 0 is 1
        residual(2,1)=yb(2); % y' at 1 is 0
    end
    
    % Initial Guess
    function yinit=funinit(x) %#ok<INUSD>
        % Guess that y = 0 and y' = 1
        yinit=[0,1];
    end
end

%% Quiz Problem
QuizProblem()
function QuizProblem()
    xx=linspace(0,1,50);
    solninit=bvpinit(xx,@funinit);
    soln=bvp4c(@odefun,@funbc,solninit);
    yy=deval(soln,xx,1);
    %fprintf('Y at x=l: %1.3f\n', yy(end))
    plot(xx,yy)

    % ODE function
    function dydx=odefun(x,y) %#ok<INUSD>
        % y(1) is y, y(2) is y'
        dydx(1,1)=y(2);
        dydx(2,1)=-exp(y(1));
    end

    % Boundary conditions
    function residual=funbc(ya,yb)
        residual(1,1)=ya(1); % y at 0 is 0
        residual(2,1)=yb(1); % y at 1 is 0
    end

    % Initial Guess
    function yinit=funinit(x)
        % Guess that y = 0 and y' = 1
        yinit=[0,1];
    end
end

%% Higher order example
PracticeProblem()
function PracticeProblem()
    xx=linspace(0,1,100);
    solninit=bvpinit(xx,@funinit);
    soln=bvp4c(@odefun,@funbc,solninit);
    yy=deval(soln,xx,1);
    tt=deval(soln,xx,3);
    %fprintf('Y at x=l: %1.3f\n', yy(end))
    plot(xx,tt); hold on
    plot(xx,yy)

    % ODE function
    function dydx=odefun(x,y)
        % y(1) is C, y(2) is C', y(3) is T
        dydx(1,1)=y(2);
        dydx(2,1)=x-2*y(1)*y(2)-5*y(1);
        dydx(3,1)=(5-2*y(3)^2)/y(1);
    end

    % Boundary conditions
    function residual=funbc(ya,yb)
        residual(1,1)=ya(1)-1; % C at 0 is 1
        residual(2,1)=ya(2)-1; % C' at 0 is 1
        residual(3,1)=yb(3)-1.5; % T at 1 is 1.5
    end

    % Initial Guess
    function yinit=funinit(x)
        yinit=[1,1,1];
    end
end

%%
higer_order_bvp_example()
function higer_order_bvp_example
t=linspace(0,1,100);
solninit=bvpinit(t,@funinit);
soln=bvp4c(@odefun,@funbc,solninit);
TT=deval(soln,t,3);
CC=deval(soln,t,1);
plot(t,TT); hold on; plot(t,CC)
    function res=funbc(ya,yb)
        res(1,1)=ya(1)-1;
        res(2,1)=ya(2)-1;
        res(3,1)=yb(3)-1.5;
    end
    function dydt=odefun(t,y)
        dydt(1,1)=y(2);
        dydt(2,1)=t-2*y(1)*y(2)-5*y(1);
        dydt(3,1)=1/y(1)*(5-2*y(3)^2);
    end
    function yinit=funinit(t)
        yinit=[1,1,1];
    end
end
