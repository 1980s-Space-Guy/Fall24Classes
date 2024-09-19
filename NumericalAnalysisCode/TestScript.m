x0 = [1, -2, -2];
options = optimset('Display', 'iter');

sol = fsolve(@TestFunc, x0, options);
