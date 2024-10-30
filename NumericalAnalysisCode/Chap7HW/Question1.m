function Question1
    x_span=[0,3];
    y0=[1;1];
    options=optimset('Display','off');
    soln=ode45(@odefun,x_span,y0,options);
    y_3=deval(soln,3,1);
    fprintf('y(3) is: %1.4f\n', y_3)
    function dydx=odefun(x,z)
        % z(1) is y, z(2) is y'
        dydx(1,1)=z(2);
        dydx(2,1)=-3*z(2)-z(1);
    end
end