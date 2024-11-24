%% Quiz problem
% silly_x=linspace(-10,10,100);
% for i=1:length(silly_x)
%     silly_y(i)=shooting_quiz(silly_x(i)); %#ok<SAGROW>
% end
% plot(silly_x,silly_y)

soln_fzero=fzero(@shooting_quiz,[-3,-2]);

timespan=[0,1];
correct_y0=[1,soln_fzero];
correct_soln=ode45(@hahahaha,timespan,correct_y0);
xx=linspace(0,1,50);
yy=deval(correct_soln,xx,2);
plot(xx,yy)

function ode_to_solve=hahahaha(~,y)
    % y(1) is y, y(2) is y'
    ode_to_solve(1,1)=y(2);
    ode_to_solve(2,1)=5*y(1);
end

function error=shooting_quiz(guess)
    timespan=[0,1];
    y0=[1,guess];
    soln_ode=ode45(@hahahaha,timespan,y0);
    dy_end=deval(soln_ode,1,2); % finds the y' value at x=1
    error=dy_end;
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
    soln_ode=ode45(@heheheha,timespan,y0);
    dy_end=deval(soln_ode,0,1); % finds the y' value at x=1
    error=dy_end-1; % difference between found value and boundary condition
end

%% BVP4C quiz problem

% Plotting to find multiple solutions
% zz=-5:15;
% for i=1:length(zz)
%     error_temp(i)=builtin_quiz(zz(i)); %#ok<SAGROW>
% end
% plot(zz,error_temp)

correct_init_1=fzero(@builtin_quiz,[-1,1]);
correct_init_2=fzero(@builtin_quiz,[10,11]);
timespan=[0,1];
correct_y0_1=[0,correct_init_1];
correct_y0_2=[0,correct_init_2];
sol1=ode45(@bwahaha,timespan,correct_y0_1);
sol2=ode45(@bwahaha,timespan,correct_y0_2);
xx=linspace(0,1,81);
yy1=deval(sol1,xx,1);
yy2=deval(sol2,xx,1);
plot(xx,yy1); hold on;
plot(xx,yy2)

function dydx=bwahaha(~,y)
    %y(1) is y, y(2) is y'
    dydx(1,1)=y(2);
    dydx(2,1)=-exp(y(1));
end

function error=builtin_quiz(guess)
    timespan=[0,1];
    y0=[0,guess];
    soln_ode=ode45(@hahaha,timespan,y0);
    dy_end=deval(soln_ode,1,1); % finds the y value at x=1
    error=dy_end;

    function dydx=hahaha(~,y)
        %y(1) is y, y(2) is y'
        dydx(1,1)=y(2);
        dydx(2,1)=-exp(y(1));
    end
end