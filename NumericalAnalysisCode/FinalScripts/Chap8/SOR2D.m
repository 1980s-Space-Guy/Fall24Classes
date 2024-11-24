%% Constant boundary values
clear all;clc;close all;             % Clear workspace and command window, 
                                     %      close all figures
L=0.5; y=L; n=81; dx=L/(n-1);        % Specify parameters of the problem
itr_max=1500; tol=10^-4; alpha=1.8;  % Set numerical parameters
T=zeros(n,n);                        % Set all element of T equal to zero
T(1,:)=50*ones(1,n);
T(:,1)=50*ones(n,1);                 % Set constant valued boundary values                
T(end,:)=25*ones(1,n);
T(:,end)=25*ones(n,1);
T_c=T;
for k=1:itr_max                      % Iterate until itr_max or convergence
    error_max=0;                     % Set max error =0 at beginning of 
                                     %      each iteration
                                     
    for i=2:n-1                      % Increment row numbers
         for j=2:n-1                 % Increment column numbers
                                     % Apply recursion relation
             T_c=get_T_c(T,i,j); 
                                     % Apply relaxation factor
             T(i,j)=T(i,j)+alpha*(T_c-T(i,j));          
                                     % Calculate relative error for each
                                     %      node
             error_t=abs((T_c-T(i,j))/T_c); 
                                     % Determine maximum relative error
             if error_t > error_max; error_max=error_t; end
         end
    end
    if error_max < tol; break; end   % Convergence check
end
if k>itr_max-1                     % Check for maximum iteration limit 
    fprintf('Maximum iterations exceeded without convergence\n')
end
% Output
x=linspace(0,0.5,n);                 % Set x values for contour map
y=linspace(0,0.5,n);                 % Set y values for contour map
[X,Y]=meshgrid(x,y);
% Be careful with the x, y coordinate.
% The 1st and 2nd indice represent row and colunm. However, it does not directly fit to Cartesian
% coordinate. Need to flip "X" and "Y" in the countour plot
figure, contour(Y,X,T,8,'ShowText','on')                     % Generate contour map from solution
figure, surf(Y,X,T)
fprintf('The 2-D BVP problem has been solved by the SOR method in %d iterations!\n',k);
%
% Nested function that applies the recursion relation
% 
    function tc=get_T_c(TT,ii,jj)
        tc=(TT(ii+1,jj)+TT(ii-1,jj)+TT(ii,jj+1)+TT(ii,jj-1))/4;
    end