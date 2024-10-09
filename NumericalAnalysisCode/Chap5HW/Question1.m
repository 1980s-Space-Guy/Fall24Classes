function Question1
xx2 = [0.001:0.001:15]; %#ok<NBRAK2>
for i = 1:length(xx2)
   yy(i)=gx(xx2(i));
end
plot(xx2, yy)
ylim([-5,5])

options=optimset('Display', 'off');
sol1_range=[4.19,4.21];
x2_sol1=fzero(@gx, sol1_range, options);
sol2_range=[4.275,4.28];
x2_sol2=fzero(@gx, sol2_range, options);
sol3_range=[4.3268,4.327];
x2_sol3=fzero(@gx, sol3_range, options);
sol4_range=[4.356,4.358];
x2_sol4=fzero(@gx, sol4_range, options);
sol5_range=[4.378,4.38];
x2_sol5=fzero(@gx, sol5_range, options);

xx2 = x2_sol1;
[x13_sol1,~]=fsolve(@fx,[1,1],options);
fprintf('Solution 1: x1 = %2.3f, x2 = %2.3f, x3 = %2.3f\n\n', x13_sol1(1) ,x2_sol1, x13_sol1(2))

xx2 = x2_sol2;
[x13_sol2,~]=fsolve(@fx,[1,1],options);
fprintf('Solution 2: x1 = %2.3f, x2 = %2.3f, x3 = %2.3f\n\n', x13_sol2(1), x2_sol2, x13_sol2(2))

xx2 = x2_sol3;
[x13_sol3,~]=fsolve(@fx,[1,1],options);
fprintf('Solution 3: x1 = %2.3f, x2 = %2.3f, x3 = %2.3f\n\n', x13_sol3(1), x2_sol3, x13_sol3(2))

xx2 = x2_sol4;
[x13_sol4,~]=fsolve(@fx,[1,1],options);
fprintf('Solution 4: x1 = %2.3f, x2 = %2.3f, x3 = %2.3f\n\n', x13_sol4(1), x2_sol4, x13_sol4(2))

xx2 = x2_sol5;
[x13_sol5,~]=fsolve(@fx,[1,1],options);
fprintf('Solution 5: x1 = %2.3f, x2 = %2.3f, x3 = %2.3f\n\n', x13_sol5(1), x2_sol5, x13_sol5(2))

    function ff=fx(z)
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
        f2=exp(xx1)*sin(xx3)-5*exp(-x2)-10;

        function ff=fx(z)
            % z(1) is x1, z(2) is x3
            x1 = z(1); x3 = z(2);
            % These need to be equal to zero
            ff(1,1)=6*x1+x3*log(x2)+x2*x3-6;
            ff(2,1)=x1+x2+x3-5;
        end
    end
end