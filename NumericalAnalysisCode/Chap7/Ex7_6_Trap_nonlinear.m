% Textbook example 7.6
%  
%                                     Program written by
%                                     Hung-Jen Wu
%

function Ex7_6_Trap_nonlinear
clear
n=20; x0=0; xf=0.5; y0=1;           % Input n and problems specifications
dx=(xf-x0)/n;                      % Calculate dx 
x(1)=x0; y(1)=y0;                  % Transfer initial conditions to x and y
for i=1:n                          % Use FOR loop to implement Euler method
    x(i+1)=x(i)+dx;                % Increment x by dx
                                   
    fy=@(yy) y(i)+dx/2*(x(i)*exp(y(i))+x(i+1)*exp(yy))-yy;  % Set equation for Trapezoidal method
    y(i+1)=fzero(fy,y(i));
end
disp(y)

