x0=[1;-1;-2];
options=optimset('Display','iter');
[x_soln,~]=fsolve(@NonlinearSystem,x0,options);
disp(x_soln)

function NLS=NonlinearSystem(x)
    x1=x(1);
    x2=x(2);
    x3=x(3);
    % Set these equal to 0
    NLS(1,1)=x1+2*x2-x3-2;
    NLS(2,1)=x1^2+4*x2^2-4;
    NLS(3,1)=x1*x2+4*x1*x3-4*x3+1;
end