function Question2
    x_span=[0,1];
    y0=[4;2];
    options=optimset('Display','off');
    soln=ode45(@odefun,x_span,y0,options);
    y1_1=deval(soln,1,1);
    y2_1=deval(soln,1,2);
    fprintf('y1(1) is: %1.4f\n', y1_1)
    fprintf('y2(1) is: %1.4f\n', y2_1)
    function dydx=odefun(x,z)
        % z(1) is y1, z(2) is y2
        dydx(1,1)=-z(1)+z(2)+x;
        dydx(2,1)=-z(1)*z(2)^2/(1+x);
    end
end