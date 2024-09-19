




xx = -10:0.1:10;
yy = zeros(size(xx));
for i=1:length(xx)
    yy(i) = sample(xx(i));
end
%plot(xx, yy)

x1_range1 = [1, 1.05];
x1_range2 = [1.9, 2];

x1_answer_1 = fzero(@sample, x1_range1);
x1_answer_2 = fzero(@sample, x1_range2);

x0 = [1; 1];

xpoop = x1_answer_1; %#ok<NASGU>
silly_sol = fsolve(@fx_this_scope, x0, optimset('Display', 'off'));
x2_answer_1 = silly_sol(1);
x3_answer_1 = silly_sol(2);

fprintf('Solution 1: x = %1.3f, y = %1.3f, z = %1.3f \n', x1_answer_1, x2_answer_1, x3_answer_1)

xpoop = x1_answer_2;
goofy_sol = fsolve(@fx_this_scope, x0, optimset('Display', 'off'));
x2_answer_2 = goofy_sol(1);
x3_answer_2 = goofy_sol(2);

fprintf('Solution 2: x = %1.3f, y = %1.3f, z = %1.3f \n', x1_answer_2, x2_answer_2, x3_answer_2)

function f = fx_this_scope(x)
    % x(1) = x2, x(2) = x3
    f = [xpoop + 2 .* x(1) - x(2) - 2;...
         xpoop .* x(1) + 4 .* xpoop .* x(2) - 4 .* x(2) + 1]; 
end

function f2 = sample(x1)
    function f = fx(x)
        % x(1) = x2, x(2) = x3
        f = [x1 + 2 .* x(1) - x(2) - 2;...
            x1 .* x(1) + 4 .* x1 .* x(2) - 4 .* x(2) + 1]; 
    end
    x0 = [1;1];
    options = optimset('Display', 'off');
    x_sol = fsolve(@fx, x0, options);
    f2 = x1 .^ 2 + 4 .* x_sol(1) .^ 2 - 4;
end