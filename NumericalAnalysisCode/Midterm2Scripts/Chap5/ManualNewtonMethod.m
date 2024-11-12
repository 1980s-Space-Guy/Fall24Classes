% Like Quiz 5
% Will be given nonlinear equations and an
% Initial guess for the varibles

IG=[1;2;1];

% To solve for the iteration, the first part is to
% Find the partials for each variable found at the
% previous guess (Jacobian)

A=[1,2,-1;
   2,16,0;
   6,1,0];

% Then you can find the b matrix by evaluating the
% negative of the functions at the previous guess

b=[-2;-13;-3];

% The change in the x values
x=A\b;

% The next values
x=x+IG;

disp(x)
