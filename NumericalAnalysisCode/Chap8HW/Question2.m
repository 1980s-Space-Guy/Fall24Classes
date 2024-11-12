function Question2
    xx=linspace(0,1,50);
    solninit=bvpinit(xx,@funinit);
    soln=bvp4c(@odefun,@funbc,solninit);
    yy=deval(soln,xx);
    plot(xx,yy)

    function dydx=odefun(x,y)
        dydx(1,1)=y(2);
        dydx(2,1)=5*y(1);
    end

    function residual=funbc(ya,yb)
        residual(1,1)=ya(1)-1; % y at 0 is 1
        residual(2,1)=yb(2); % y' at 1 is 0
    end
    
    function yinit=funinit(x)
        % Guess that y = 0 and y' = 1
        yinit=[0,1];
    end
end