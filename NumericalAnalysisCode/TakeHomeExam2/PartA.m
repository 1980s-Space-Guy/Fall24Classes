function PartA
    % Creating Spline functions from the data table given
    altitude=Altitude();
    gravity_func=spline(altitude.height,altitude.gravity);
    density_func=spline(altitude.height,altitude.density);
    viscosity_func=spline(altitude.height,altitude.viscosity);
    
    % Ball info
    r=0.05; % m
    rho_ball=7860; % kg/m3
    m=4/3*pi*r^3*rho_ball; % kg
    drop_height=1000; % m

    % Solving ODE
    tspan=[0,75]; % Simulating the ball being dropped from t=0 s to t=75 s
    y0=[drop_height,0]; % Dropping the ball from rest at 1000 m, so the
                        % speed at t = 0 s is 0 m/s
    options=odeset('RelTol',10e-9,'AbsTol',10e-9);
    function ode=FallingODE(t,z)
        % z(1) is y, z(2) is y'
        % Interpolating for gravity, density and viscosity at the altitude
        g=ppval(gravity_func,z(1));
        rho_air=ppval(density_func,z(1));
        mu=ppval(viscosity_func,z(1));
        % Taking the absolute value of the velocity was needed for
        % finding the drag coefficient
        Re=rho_air*abs(z(2))*2*r/mu;
        Cd=DragCoefficient(Re,abs(z(2)));
        % Ode function
        ode(1,1)=z(2);
        ode(2,1)=-g+1/2*rho_air*Cd*pi*r^2*z(2)^2/m;
    end
    ode_soln=ode45(@FallingODE,tspan,y0,options);

    % Plotting resulting y function
    tt=linspace(0,75,1000);
    yy=deval(ode_soln,tt,1);
    plot(tt,yy);

    % Using nonlinear solver to find the time when the ball hits the ground
    function height=height_func(time)
        height=deval(ode_soln,time,1);
    end
    options=optimset('Display','off');
    ground_hit_time=fzero(@height_func,tspan,options);
    % Getting the speed when the ball hits the ground
    ground_hit_speed=abs(deval(ode_soln,ground_hit_time,2));

    % Calculating the change in thermal energy
    grav_int=fnint(gravity_func);
    change_PE=m*(ppval(grav_int,0)-ppval(grav_int,drop_height));
    change_KE=1/2*m*ground_hit_speed^2;
    change_TE=-change_KE-change_PE;
    TE_generated=abs(change_TE);

    % Output
    fprintf('Time taken to hit ground: %2.3f s\n',ground_hit_time)
    fprintf('Speed when ground hit: %2.3f m/s\n',ground_hit_speed)
    fprintf('Thermal energy generated: %5.0f J\n\n', TE_generated)
end