% Shooting Method
shooting_fluids()
function shooting_fluids
    mu1=10;
    mu2=5;
    v0=0; vn=0;
    options=optimset('Display','off');

    % First liquid phase
    yspan1=[0,0.5];
    % Second liquid phase
    yspan2=[0.5,1];

    correct_dvdy=fzero(@shooting_zero,[-1,1],options);
    correct_vinit1=[v0,correct_dvdy];
    correct_sol1=ode45(@fluid_ode1,yspan1,correct_vinit1,options);
    correct_vinit2=[deval(correct_sol1,0.5,1),mu1/mu2*deval(correct_sol1,0.5,2)];
    correct_sol2=ode45(@fluid_ode2,yspan2,correct_vinit2,options);
    yy1=linspace(0,0.5,100);
    yy2=linspace(0.5,1,100);
    Vx_1=deval(correct_sol1,yy1,1);
    Vx_2=deval(correct_sol2,yy2,1);
    plot(Vx_1,yy1);
    hold on;
    plot(Vx_2,yy2);

    function dvdy=fluid_ode1(y,z)
        % z(1) is vx, z(2) is dvxdy
        dvdy(1,1)=z(2);
        dvdy(2,1)=-10/mu1;
    end

    function dvdy=fluid_ode2(y,z)
        % z(1) is vx, z(2) is dvxdy
        dvdy(1,1)=z(2);
        dvdy(2,1)=-10/mu2;
    end

    function error=shooting_zero(guess)
        vinit1=[v0,guess];
        soln1=ode45(@fluid_ode1,yspan1,vinit1,options);

        % The first one is that the 2 phases have the same velocity,
        % The second one is that they have the same momentum (look at
        % multiple boundaries problem)
        vinit2=[deval(soln1,0.5,1),mu1/mu2*deval(soln1,0.5,2)];
        soln2=ode45(@fluid_ode2,yspan2,vinit2,options);
        % zero function to see if the boundary condition is satisfied
        error=deval(soln2,1,1)-vn;

        function dvdy=fluid_ode1(y,z)
            % z(1) is vx, z(2) is dvxdy
            dvdy(1,1)=z(2);
            dvdy(2,1)=-10/mu1;
        end

        function dvdy=fluid_ode2(y,z)
            % z(1) is vx, z(2) is dvxdy
            dvdy(1,1)=z(2);
            dvdy(2,1)=-10/mu2;
        end
    end
end

%% bvp4c
% bvp4c doesn't like if statements, so use region thing
% WRONG

fluid_bvp4c()
function fluid_bvp4c
    mu1=10;
    mu2=5;
    v0=0; vn=0;
    options=optimset('Display','off');
    % This is where you give the code the information of where the
    % interface between the fluids is
    ymesh=[linspace(0,0.5,101),linspace(0.5,1,101)];
    zinit=[0,0];
    init_guess=bvpinit(ymesh,zinit);
    soln=bvp4c(@fluid_ode1,@residual,init_guess,options);
    yy=linspace(0,1,201);
    vv=deval(soln,yy,1);
    plot(vv,yy)

    function res=residual(YL,YR)
        % YL and YR represent the different regions (YL is bottom
        % YR is top). For these variables, the first number given is
        % the index of the ode (1 is Vx, 2 is dVx/dy) the second number
        % is the boundary of the function (1 is the first, 2 is the second)
        res(1,1)=YL(1,1)-v0;
        res(2,1)=YR(2,1)-vn;
        res(3,1)=YR(1,1)-YL(1,2);
        res(4,1)=mu1*YR(2,1)-mu2*YL(2,2);
    end

    function dvdy=fluid_ode1(y,z,region)
        % z(1) is vx, z(2) is dvxdy
        switch region
            case 1
                dvdy(1,1)=z(2);
                dvdy(2,1)=-10/mu1;
            case 2
                dvdy(1,1)=z(2);
                dvdy(2,1)=-10/mu2;
        end
    end
end