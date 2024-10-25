%% Quiz problem
soln_fzero=fzero(@shooting_quiz,[-3,-2]);

timespan=[0,1];
correct_y0=[1,soln_fzero];
correct_soln=ode45(@hahahaha,timespan,correct_y0);
xx=linspace(0,1,50);
yy=deval(correct_soln,xx,1);
plot(xx,yy)

function ode_to_solve=hahahaha(~,y)
    %y(1) is y, y(2) is y'
    ode_to_solve(1,1)=y(2);
    ode_to_solve(2,1)=5*y(1);
end

function error=shooting_quiz(guess)
    timespan=[0,1];
    y0=[1,guess];
    soln_ode=ode45(@hahaha,timespan,y0);
    dy_end=deval(soln_ode,1,2); % finds the y' value at x=1
    error=dy_end;

    function ode_to_solve=hahaha(~,y)
        %y(1) is y, y(2) is y'
        ode_to_solve(1,1)=y(2);
        ode_to_solve(2,1)=5*y(1);
    end
end

%% In Class example (going backwards)
soln_fzero=fzero(@shooting_practice,[0,1]);

timespan=[1,0];
correct_y0=[1,soln_fzero,0];
correct_soln=ode45(@heheheha,timespan,correct_y0);
xx=linspace(0,1,50);
yy=deval(correct_soln,xx,1);
plot(xx,yy)

function ode_to_solve=heheheha(~,y)
    %y(1) is y, y(2) is y', y(3) is y''
    ode_to_solve(1,1)=y(2);
    ode_to_solve(2,1)=y(3);
    ode_to_solve(3,1)=-y(2)-4*y(1);
end

function error=shooting_practice(guess)
    timespan=[1,0];
    y0=[1,guess,0];
    soln_ode=ode45(@hehehe,timespan,y0);
    dy_end=deval(soln_ode,0,1); % finds the y' value at x=1
    error=dy_end-1; % difference between found value and boundary condition

    function ode_to_solve=hehehe(~,y)
        %y(1) is y, y(2) is y', y(3) is y''
        ode_to_solve(1,1)=y(2);
        ode_to_solve(2,1)=y(3);
        ode_to_solve(3,1)=-y(2)-4*y(1);
    end
end