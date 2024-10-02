%% initialize
x=0:pi/7:pi;
y=sin(x);
spline_func=spline(x,y);

%% spline function details
% for the coefs, the values in the first column are for the coefficients
% of the cubic terms. The last column are constants
disp(spline_func.coefs)

%% ppval - gives values for piecewise function, which spline returns
xq=0:pi/30:pi;
yq=ppval(spline_func, xq);
%plot(xq, yq)

%% differentiation of the piecewise function
d1=fnder(spline_func);

%% finding when differential becomes 0
xd1=0:pi/100:pi;
yd1=ppval(d1, xd1);
%plot(xd1,yd1)

f=@(xxd1) ppval(d1,xxd1);
options=optimset('Display','off');
max_sol=fzero(f,[0,pi],options);
disp(max_sol)

%% integration
xi1=fnint(spline_func);
yintegral=ppval(xi1,pi)-ppval(xi1,0);
disp(yintegral)