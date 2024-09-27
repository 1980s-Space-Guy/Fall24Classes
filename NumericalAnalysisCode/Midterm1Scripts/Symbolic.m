syms x
f1=x^2+2*x-1/x;
f2=(x+3)*(x-2);
f3=(x^2-7*x+10)/(x-2);
f4=(x^2-7*x+10);

fexam=(cos(x)+x^2)/(sin(x)^2-6*x+1);

%% Expand
disp(expand(f2))

%% Factor
disp(factor(f4))

%% Simplify
disp(simplify(f3))

%% Substitute
disp(subs(f1, 2))

%% Convert to a MATLAB anonymous function
f1_good = matlabFunction(f1);
A=[2,3;...
   4,6];
disp(f1_good(A))

%% Derivatives
disp(diff(f1, x, 2))

%% Integrals
disp(int(f1, x))

%% Exam Problem
integral=vpa(int(fexam,x,1,5));
disp(integral)
derivative=diff(fexam,x);
fp_exam=matlabFunction(derivative);
disp(fp_exam(1))