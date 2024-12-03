%% Video Problem
Video()
function Video
    n=41; dx=1/(n-1);
    t0=0; tf=15; 
    Y0(1:n-1)=10; Y0(n)=25; % Input problem specifications
    
    options=odeset('RelTol',10^-5,'AbsTol',10^-8);
    soln=ode15s(@f,[t0 tf],Y0',options);
    
    % Gets solutions at these times
    output_y1=deval(soln,0.88);
    output_y2=deval(soln,5);
    output_y3=deval(soln,15);
    xp=linspace(0,1,n);

    plot(xp,output_y1); hold on; plot(xp,output_y2); plot(xp,output_y3);
    xlabel('x'); ylabel('Y');
    grid on;
    legend('t=0.88 sec','t=5 sec','t=15 sec')

    % User specified function for dydx for each dependent variable
    function dYdt=f(~,y)
        % beginning dydt
        dYdt(1)=0;
        for i=2:n-1
            % Calculate dY/dx for interior nodes
            dYdt(i)=0.01*(y(i+1)-2.*y(i)+y(i-1))/dx^2; %#ok<AGROW>
        end
        % End dydt
        dYdt(n)=0;
        dYdt=dYdt'; % Specify dY/dx in column vector form
    end
end


%% Homework Problem
HWprob()
function HWprob
    n=41; dx=1/(n-1);
    t0=0; tf=1; 
    Y0(1:n-1)=1; Y0(n)=2; % Input problem specifications
    
    options=odeset('RelTol',10^-5,'AbsTol',10^-8);
    soln=ode15s(@f,[t0 tf],Y0',options);
    
    % Gets solutions at these times
    output_y1=deval(soln,0.03);
    output_y2=deval(soln,0.12);
    output_y3=deval(soln,1);
    xp=linspace(0,1,n);

    plot(xp,output_y1); hold on; plot(xp,output_y2); plot(xp,output_y3);
    xlabel('x'); ylabel('Y');
    grid on;
    legend('t=0.03 sec','t=0.12 sec','t=1 sec')

    % User specified function for dydx for each dependent variable
    function dYdt=f(~,y)
        % beginning dydt
        dYdt(1)=0;
        for i=2:n-1
            % Calculate dY/dx for interior nodes
            dYdt(i)=(y(i+1)-2.*y(i)+y(i-1))/dx^2+(y(i+1)-y(i-1))/(2*dx); %#ok<AGROW>
        end
        % End dydt
        dYdt(n)=0;
        dYdt=dYdt'; % Specify dY/dx in column vector form
    end
end

%% 2D MOL
IVP_MOD_2D_BPV()
function soln=IVP_MOD_2D_BPV
    L=0.5; n=21; dx=L/(n-1); k=5;
    T0=40*ones(n,n);
    T0(1,:)=50*ones(1,n);
    T0(:,1)=50*ones(n,1);
    T0(end,:)=25*ones(n,1);
    T0(:,end)=25*ones(1,n);
    y0=reshape(T0,[n^2,1]);
    tspan=[0,100];
    soln=ode15s(@f,tspan,y0);
    
    function dydt=f(t,y)
        T=reshape(y,[n,n]);
        dYdt=zeros(n,n);
        for i=2:n-1
            for j=2:n-1
                dYdt(i,j)=k/dx^2*(T(i-1,j)-2*T(i,j)+T(i+1,j) ...
                    +T(i,j-1)-2*T(i,j)+T(i,j+1));
            end
        end
        dydt=reshape(dYdt,[n^2,1]);
    end

    n=21;
    x=linspace(0,0.5,n);
    y=linspace(0,0.5,n);
    [X,Y]=meshgrid(x,y);
    time_stamp=0.1;
    T_output=deval(soln,time_stamp);
    T_plot=reshape(T_output,[n,n]);
    contour(X,Y,T_plot,10,'ShowTex','on')
end
