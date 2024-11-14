function Question1
clc;close all;                       % Clear workspace and command window, 
                                     %      close all figures
L=1;                                 % Set the length of the spatial domain
n=21;                                % Set the number of node points
dx=L/(n-1);                          % Calculate the separation of node pts
x=linspace(0,n-1,n)*dx;              % Set the locations of the node points
itr_max=1500;                        % Set the maximum iterations
tol=1e-6;                            % Specify the convergence criterion
alpha=1.8;                           % Set the overrelaxation factor
                                     % Initialize unknown values of the 
                                     %      dependent variables
y0=30*ones(n,1);                     % Set the initial guesses for the node
y0(1)=1;                             %     point values
y0(end)=(4*y0(n-1)-y0(n-2))/3;
Y=y0;                                % Use initial guesses for initial 
Y_c=Y;                               %      value of Y
for i=1:itr_max
    error=0;
    for j=2:n
        if j==n
            Y_c(j)=(4*Y_c(n-1)-Y_c(n-2))/3;
        else
            Y_c(j)=get_Y_c(Y,j);  
        end
                % Using nested function calculate Y_cal
                                    % Apply SOR
        
        Y(j)=Y(j)+alpha*(Y_c(j)-Y(j)); 
                                    % Calculate relative error
        error_t=abs((Y_c(j)-Y(j))/Y_c(j)); 
                                    % Find maximum relative error
        if error_t>error; error=error_t; end 
    end

    if error<tol; break; end        % Check for convergence
end
fprintf('Y at x=l: %1.3f\n', Y(end))

plot(x,Y)
%
% Nested function for applying recursion relation
%
    function yc=get_Y_c(YY,ii)
                                    % Apply recursion relation
        yc=(YY(ii-1)+YY(ii+1))/(5*dx^2+2);
    end
end