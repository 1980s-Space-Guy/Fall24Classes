function re = reynolds_number(rho, fv, mu, d)
%Finds the Reynolds Number of a fluid moving through a pipe
%   rho is the density in kg/m3
%   fv is the flow velocity in m/s
%   mu is the dynamic viscosity in kg/m s
%   d is the inner diameter of the pipe in m

re = rho * fv * d / mu;

end

