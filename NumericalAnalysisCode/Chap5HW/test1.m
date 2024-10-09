xx2 = [0.001:0.001:15]; %#ok<NBRAK2>
for i = 1:length(xx2)
   yy(i)=nonlinear_eq(xx2(i));
end
plot(xx2, yy)
ylim([-5,5])

x_2_ans=fzero(@nonlinear_eq,[4.19,4.21]);

A=[6,log(x_2_ans)+x_2_ans;
   1,1];
B=[6;
   5-x_2_ans];
soln=A\B;
answer=[soln(1),x_2_ans,soln(2)];

disp(answer)

function f=nonlinear_eq(x2)
    A=[6,log(x2)+x2;
       1,1];
    B=[6;
       5-x2];
    solng=A\B;
    x1=solng(1);
    x3=solng(2);
    f=exp(x1)*sin(x3)-5*exp(-x2)-10;
end
