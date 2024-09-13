function ff = friction_factor(Re)
%Finds the friction factor of an incompressible liquid given its Reynolds
%Number
%   Detailed explanation goes here

if Re <= 2100
    ff = 16 / Re;
elseif Re >= 10 ^ 5
    ff = 0.004;
else
    ff = 0.0791 / Re ^ 0.25;

end

