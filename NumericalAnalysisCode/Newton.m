f = @(x) x ^ 2 - 2 * x + 1;
fp = @(x) 2 * x - 2;

xi = 2;

xip1 = xi - f(xi) / fp(xi);

disp (xip1)