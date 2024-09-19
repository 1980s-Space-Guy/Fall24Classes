function f = TestFunc(x)
%TESTFUNC Summary of this function goes here
%   Detailed explanation goes here

f1 = x(1) + 2 * x(2) - x(3) - 2;
f2 = x(1) ^ 2 + 4 * x(2) ^ 2 - 4;
f3 = x(1) * x(2) + 4 * x(1) * x(3) - 4 * x(3) + 1;

f = [f1; f2; f3];

end

