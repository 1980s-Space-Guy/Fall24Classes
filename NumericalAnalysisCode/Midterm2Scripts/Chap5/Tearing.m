% Things you will have to change:

% First thing to do is to choose the variable.
% By choosing a varible, you should have two of your equations simplify
% to a system of linear equations (by assuming the variable you chose is
% a constant)

% Functions in the fx and fx2 functions should be changed to the same
% thing, but the variable that you are assuming should be different
% in the functions
% for fx, it should be the same as the variable you are passing through gx
% for fx2, it should be the same as what you are assigning the solutions
% you get from fzero

% In the gx function, change the variables gotton from fsolve to the ones
% That aren't pre determined. Then use the formula you didn't use to find
% the undetermined variables to check if your solution is valid (equals 0)

% Make a solution sequence for every root you are trying to find

function Tearing
% first part where you see how many solutions you have

xx2 = [0.01:0.01:10]; %#ok<NBRAK2> # Change x bounds to find intersections
for i = 1:length(xx2)
    yy(i)=gx(xx2(i)); %#ok<AGROW>
end
plot(xx2, yy)
ylim([-5,5])

% Second Part where you use boundaries from the graph to get your answers
options=optimset('Display', 'off');

% sol1_range=[0.9,1.2];
% x1_sol1=fzero(@gx, sol1_range, options);
% xx2 = x1_sol1;
% [x23_sol1,~]=fsolve(@fx2,[1,1],options);
% fprintf('Solution 1: x1 = %2.3f, x2 = %2.3f, x3 = %2.3f\n\n', x1_sol1, x23_sol1(1), x23_sol1(2))
% 
% sol2_range=[1.8,2.2];
% x1_sol2=fzero(@gx, sol2_range, options);
% xx2 = x1_sol2;
% [x23_sol2,~]=fsolve(@fx2,[1,1],options);
% fprintf('Solution 2: x1 = %2.3f, x2 = %2.3f, x3 = %2.3f\n\n', x1_sol2, x23_sol2(1), x23_sol2(2))

    function ff=fx2(z)
        % z(1) is x1, z(2) is x3
        x1 = z(1); x3 = z(2);
        % These need to be equal to zero
        ff(1,1)=6*x1+x3*log(xx2)+xx2*x3-6;
        ff(2,1)=x1+xx2+x3-5;
    end

    function f2=gx(x2)
        options=optimset('Display', 'off');
        [x_sol,~] = fsolve(@fx,[0,0], options);
        xx1 = x_sol(1); xx3 = x_sol(2);
        % This also needs to equal 0
        f2=exp(xx1)*sin(xx3)-5*exp(-x2)-10;

        function ff=fx(z)
            % z(1) is x2, z(2) is x3
            x1 = z(1); x3 = z(2);
            % These need to be equal to zero
            ff(1,1)=6*x1+x3*log(x2)+x2*x3-6;
            ff(2,1)=x1+x2+x3-5;
        end
    end
end