x = [0, 1, 2, 3, 4, 5, 6];
fx = [0, 10, 13, 15, 16, 17, 18];

%% Question 2
x1 = 1; x2 = 2; x3 = 3;
fx1 = 10; fx2 = 13; fx3 = 15;

A = [1, x1, x1^2,;...
     1, x2, x2^2;...
     1, x3, x3^2];

b = [fx1; fx2; fx3];

disp(A\b)

%% Question 3

fv = spline(x, fx, 5.5);
disp(fv)