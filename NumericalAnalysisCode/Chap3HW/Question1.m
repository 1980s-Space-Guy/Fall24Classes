%% Reformulated equation
fn = @(x) x .^ 2 .* (6.76 - 0.5 .* x) - 62.4e6 .* (1 - 0.5 .* x) .*...
    ((2 - x) .^ 2);

fnp = @(x) 31200000 .* (x - 2) .^2 - 2 .* x .* (x ./ 2 - 169 ./ 25) +...
    (2 .* x - 4) .* (31200000 .* x - 62400000) - x .^ 2 ./ 2;

%% Plot
xx = 0:0.01:2;
yy = fn(xx);

plot(xx, yy)

%% Symbolic function
syms x

fs = x .^ 2 .* (6.76 - 0.5 .* x) - 62.4e6 .* (1 - 0.5 .* x) .*...
    ((2 - x) .^ 2);
fsp = diff(fs);

%% Part A: Newton's Method

xi = 0.1; % gmol

for i = 1:1000
    xip1 = xi - (fn(xi) / fnp(xi));
    if abs(xi - xip1) < 10e-6
        break
    end
    xi = xip1;
end
fprintf('Newtons Method solution: \n')
fprintf('gmol CO : %.6f \n', 2 - xip1)
fprintf('gmol O2 : %.6f \n', 1 - 0.5 * xip1)
fprintf('gmol CO2 : %.6f \n', xip1)
fprintf('Iterations: %i \n \n', i)

%% Part B: Bisection Method

a = 0;
b = 2;

for i = 1:2000
    if abs(a - b) < 10e-6
        break
    end
    p = (a + b) / 2;
    if fn(p) * fn(a) > 0
        a = p;
    else
        b = p;
    end
end
fprintf('Bisection Method solution: \n')
fprintf('gmol CO : %.6f \n', 2 - a)
fprintf('gmol O2 : %.6f \n', 1 - 0.5 * a)
fprintf('gmol CO2 : %.6f \n', a)
fprintf('Iterations: %i \n \n', i)

%% Part C: MATLAB function

sol = fzero(fn, [1.9, 2]);
fprintf('MATLAB solution: \n')
fprintf('gmol CO : %.6f \n', 2 - sol)
fprintf('gmol O2 : %.6f \n', 1 - 0.5 * sol)
fprintf('gmol CO2 : %.6f \n', sol)