%initial conditions
max_iterations=20;

fx1=@(x2,x3) 7/6+1/6*x2-1/6*x3;
fx2=@(x1,x3) 3/2-1/4*x1+1/4*x3;
fx3=@(x1,x2) 9/4-1/4*x1+1/2*x2;

% initail_guess
x1=0;
x2=0;
x3=0;

i=0;
while i<max_iterations
    i=i+1;
    if abs(fx1(x2,x3)-x1) < 10^-6
        break
    end
    x1=fx1(x2,x3);
    x2=fx2(x1,x3);
    x3=fx3(x1,x2);
end

disp(x1)
disp(x2)
disp(x3)