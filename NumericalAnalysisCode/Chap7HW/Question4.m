function Question4
    t_span=[1,100];
    y0=[1;300];
    options=optimset('Display','off');
    soln=ode45(@odefun,t_span,y0,options);
    CA_100=deval(soln,100,1);
    T_100=deval(soln,100,2);
    fprintf('CA(100) is: %1.4f gmol/L\n', CA_100)
    fprintf('T(100) is: %3.0f K\n', T_100)
    function dydx=odefun(t,z)
        % z(1) is Ca (gmol/L), z(2) is T (K)
        EoverR=300; % K
        K1=-0.1; % 1/s
        K2=1; % K/gmol s
        dydx(1,1)=K1*z(1)*exp(-EoverR/z(2));
        dydx(2,1)=K2*z(1)*exp(-EoverR/z(2));
    end
end