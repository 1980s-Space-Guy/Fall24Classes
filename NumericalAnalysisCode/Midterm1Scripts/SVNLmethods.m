%% Newton
syms X
sym_f=X^2*(6.76-0.5*X)-62.4*10^6*(1-0.5*X)*(2-X)^2;
sym_fp=diff(sym_f,X);
f=matlabFunction(sym_f);
fp=matlabFunction(sym_fp);

% xip1 is a placeholder
xip1=0;
xi=0.1;

max_iterations=100;
i=0;

while i < max_iterations
    i=i+1;
    xip1=xi-f(xi)/fp(xi);
    if abs(xip1 - xi) < 10^-6
        disp(i)
        break
    end
    xi=xip1;
end

fprintf('Result using Newton method: %.6f\n', xip1)

%%  Secant
f=@(x)x^2-2*x+1;

xip1=0;
xi=2;
xim1=2.1;

max_iterations=100;
i=0;

while i < max_iterations
    i=i+1;
    xip1=xi-f(xi)*(xi-xim1)/(f(xi)-f(xim1));
    if abs(xip1 - xi) < 10^-6
        break
    end
    xi=xip1;
end

fprintf('Result using Secant method: %.4f\n', xip1)

%% Bisection Method
f=@(x)x^3-4*x^2+x-6;

a=3;
b=5;

max_iterations=100;
i=0;

while i < max_iterations
    i=i+1;
    p=(a+b)/2;
    if f(p)*f(a) > 0
        a=p;
    else
        b=p;
    end
    if abs(a - b) < 10^-6
        break
    end
end

fprintf('Result using Bisection method: %.4f\n', a)

%% Regula Falsi Method
f=@(x)x^3-4*x^2+x-6;

a=3;
b=5;

max_iterations=100;
i=0;

while i < max_iterations
    i=i+1;
    p=b-f(b)*(b-a)/(f(b)-f(a));
    if f(p)*f(a) > 0
        a=p;
    else
        b=p;
    end
    if abs(a - b) < 10^-6
        break
    end
end

fprintf('Result using Regula Falsi method: %.4f\n', a)