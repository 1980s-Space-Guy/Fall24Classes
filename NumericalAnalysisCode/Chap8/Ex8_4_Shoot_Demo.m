%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                               NOMENCLATURE
%
% dx - step size of spatial domain to print out results
% L - total length of spatial domain
% n - number of nodes for the output of the solution
% options_1 - setting convergence criterion for black box function
% options_2 - setting convergence criterion for ODE integrator
% RelTol - the relative tolerance convergence criterion for ode45
% TolX - the relative tolerance convergence criterion for fzero
% x - the spatial location of the solution results
% y0 - left boundary value of Y
% y_end - right boudary value of Y
% y_soln - dependent variable value for the solution of the BVP
% z - first derivative of Y, z=dY/dx
% z0 - left boundary value of z
% z0_guess - the initial guess for z(0)
%
%                                                       Written by Shu Xu
%                                                       08/03/2013
%                                                Modified 9/4/13 JBR
%                                                Modified 04/17/2017 HJW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 PROGRAM
function Ex8_4_Shoot_Demo

clear all;clc;close all;             % Clear workspace and command window, 
                                     %      close all figures
L=5;                                 % Set length of spatial domain
n=11; dx=L/(n-1);                    % Set parameters for output of results
x=linspace(-n,n-1,n)*dx;
options_1=optimset('TolX',10^-8);    % Set convergence criteria for fzero
options_2=odeset('RelTol',10^-4);    % Set convergence criteria for ode45
z0_guess=-10;                        % Set initial guess for z(0)
                                                     
y0=100;                              % Initialize boundary values for the 
y_end=0;                             %      governing differential eqn

zz0=-7:7:100;
for i=1:length(zz0)
    ini_0=[y0,zz0(i)];
    [~, Y_soln]=ode45(@shooting_bvp,x,ini_0,options_2);
    endpoint(i)=Y_soln(end,1);
end
plot(zz0,endpoint)


%                                      % Call fzero to solve black box funct
% z0=fzero(@black_box,z0_guess,options_1);
%                                      % Using the converged results for ICs,
%                                      %      generate dependent variable 
%                                      %      values for plotting
% [~,y_soln]=ode45(@shooting_bvp,x,[y0,z0],options_2);
% warning('off','all'); % suppress warnings
%% Output %%
fprintf('The BVP problem has been solved by the shooting method!\n');
fprintf('The distribution of dependent variable values is:\n');
fprintf('Nodes,\t Position,\t Y value\n');
k=0;
for i=1:n
    fprintf(' I=%d,\t L=%2.5f,\t Y=%2.5f\n',i,x(i),y_soln(i,1));
end
%
%  This nested function provides the ODEs for the governing differential eqn
%
function dydx=shooting_bvp(~,y_soln)
dydx=zeros(2,1);
dydx(1)=y_soln(2);                    % dydx(1)=dy/dx
dydx(2)=-0.1*y_soln(1)*y_soln(2);     % dydx(2)=d2y/d2x=dz/dx
end
%
% This nested function provides the value of the blackbox function given  
%     the unknown initial condition
%
function error=black_box(z00)
ini_0=[y0,z00];                      % Set initial conditions for ODEs 
                                     % Call ode45 to integrate ODEs
[~, Y_soln]=ode45(@shooting_bvp,x,ini_0,options_2);
error=y_end-Y_soln(end,1);           % Black box function value is error
                                     %     between calculated and specified
                                     %     boundary condition
end
end
%                                PROGRAM END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%