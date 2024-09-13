syms a b x

f = 1 / (a^2 + b^2 * x^2);

dfdx = int(f, x);

disp(dfdx)