quiz_problem()
function quiz_problem
xx=linspace(0,1,50);
solninit=bvpinit(xx,@funinit);
soln=bvp4c(@odefun,@funbc,solninit);
yy=deval(soln,xx,1);
plot(xx,yy)

    function dydx=odefun(x,y)
        dydx(1,1)=y(2);
        dydx(2,1)=-exp(y(1));
    end

    function residual=funbc(ya,yb)
        residual(1,1)=ya(1);
        residual(2,1)=yb(1);
    end
    
    function yinit=funinit(x)
        yinit=[0,1];
    end
end