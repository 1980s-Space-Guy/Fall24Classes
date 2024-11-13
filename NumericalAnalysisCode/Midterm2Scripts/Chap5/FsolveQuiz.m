x0=[1;1;1];
options=optimset('Display','iter');
[x_soln,~]=fsolve(@NonlinearSystem,x0,options);
disp(x_soln)

function NLS=NonlinearSystem(x)
    x1=x(1);
    x2=x(2);
    x3=x(3);
    % Set these equal to 0
    NLS(1,1)=x1^2+2*x2+x3^3-6;
    NLS(2,1)=x1+4*x2+sin(x3)-9.8;
    NLS(3,1)=cos(x1)+sin(x2)^2+5*x3-6.4;
end