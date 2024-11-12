%% Setup
dx=1;
xx=[-1.6,7.6,15.4,26.1,42.2,60.6];
ff=[20,40,60,100,200,400];

x=25;
for i=1:length(xx)
    if xx(i)>x
        % for linear interpolation
        i1=i-1;
        i2=i;
        
        % for quadratic interpolation
        if x-xx(i-1)<=xx(i)-x | i==length(xx)
            q1=i-2;
            q2=i-1;
            q3=i;
        elseif x-xx(i-1)>=xx(i)-x | i==2
            q1=i-1;
            q2=i;
            q3=i+1;
        end
        break
    end
end

%% Linear Interpolation
f=ff(i1)+(ff(i2)-ff(i1))*(x-xx(i1))/(xx(i2)-xx(i1));
disp(f)

%% Quadratic Interpolation
A=[1,xx(q1),xx(q1)^2;
   1,xx(q2),xx(q2)^2;
   1,xx(q3),xx(q3)^2];
b=[ff(q1);ff(q2);ff(q3)];

coeffs=A\b;
f=coeffs(1)+coeffs(2)*x+coeffs(3)*x^2;
disp(f)

%% Spline Function
f=spline(xx,ff,x);
disp(f)