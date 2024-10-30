function Question3
    x_span=[0,1000];
    y0=[4;1.1;4.0];
    options=optimset('Display','off');
    soln=ode15s(@odefun,x_span,y0,options);
    y1_1000=deval(soln,1000,1);
    y2_1000=deval(soln,1000,2);
    y3_1000=deval(soln,1000,3);
    fprintf('y1(1000) is: %1.2f\n', y1_1000)
    fprintf('y2(1000) is: %3.0f\n', y2_1000)
    fprintf('y3(1000) is: %1.2f\n', y3_1000)
    function dydx=odefun(x,z)
        % z(1) is y1, z(2) is y2, z(3) is y3
        dydx(1,1)=77.27*(z(2)-z(1)*z(2)+z(1)-8.375*10^-6*z(1)^2);
        dydx(2,1)=(z(3)-z(2)-z(1)*z(2))/77.27;
        dydx(3,1)=0.162*(z(1)-z(3));
    end
end