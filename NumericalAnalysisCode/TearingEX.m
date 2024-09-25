function TearingEX
xx1 = [-1:0.001:5]; %#ok<NBRAK2>
for i = 1:length(xx1)
    yy(i)=gx(xx1(i));
end
plot(xx1, yy)
ylim([-5,5])

% options=optimset('Display', 'off');
% sol1_range=[0.8,1.2];
% x1_sol1=fzero(@gx, sol1_range, options);
% sol2_range=[1.8,2.2];
% x1_sol2=fzero(@gx, sol2_range, options);
% 
% xx1 = x1_sol1;
% [x23_sol1,~]=fsolve(@fx2,[1,1],options);
% fprintf('Solution 1: x1 = %2.3f, x2 = %2.3f, x3 = %2.3f\n\n', x1_sol1, x23_sol1(1), x23_sol1(2))
% 
% xx1 = x1_sol2;
% [x23_sol2,~]=fsolve(@fx2,[1,1],options);
% fprintf('Solution 2: x1 = %2.3f, x2 = %2.3f, x3 = %2.3f\n\n', x1_sol2, x23_sol2(1), x23_sol2(2))


    function ff=fx2(z)
        % z(1) is x2, z(2) is x3
        x2 = z(1); x3 = z(2);
        % These need to be equal to zero
        ff(1,1)=xx1+2*x2-x3-2;
        ff(2,1)=xx1*x2+4*xx1*x3-4*x3+1;
    end

    function f2=gx(x1)
        options=optimset('Display', 'off');
        [x_sol,~] = fsolve(@fx,[0,0], options);
        xx2 = x_sol(1); xx3 = x_sol(2);
        f2=x1*xx2*xx3-1;

        function ff=fx(z)
            % z(1) is x2, z(2) is x3
            x2 = z(1); x3 = z(2);
            % These need to be equal to zero
            ff(1,1)=x1+log(x1+2)+x2-7;
            ff(2,1)=x2+x3-1;
        end
    end
end