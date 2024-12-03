
function Question3
clear all;clc;close all;             % Clear workspace and command window, 
                                     %      close all figures
L=0.5; y=L; n=41; dx=L/(n-1);        % Specify parameters of the problem
itr_max=1500; tol=10^-4; alpha=1.8;   % Set numerical parameters
T=zeros(n,n);                        % Set all element of T equal to zero               
                                     % Set constant valued boundary values                
T(n,:)=25*ones(1,n);
T(:,n)=25*ones(n,1);
% T(end,:)=25*ones(1,n);
% T(:,end)=25*ones(n,1);
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
    % Recursion relation at y=0
    for i=2:n-1; T(i,1)=(4*T(i,2)-T(i,3))/3; end
    % recursion relation at x=0
    for j=2:n-1; T(1,j)=(4*T(2,j)-T(3,j))/3; end
    T(1,1)=(T(2,1)+T(1,2))/2;
    if error_max < tol; break; end   % Convergence check
end
if k>itr_max-1                     % Check for maximum iteration limit 
    fprintf('Maximum iterations exceeded without convergence\n')
end
x=linspace(0,0.5,n);                 % Set x values for contour map
y=linspace(0,0.5,n);                 % Set y values for contour map
[X,Y]=meshgrid(x,y);
% Be careful with the x, y coordinate.
% The 1st and 2nd indice represent row and colunm. However, it does not directly fit to Cartesian
% coordinate. Need to flip "X" and "Y" in the countour plot
figure, contour(Y,X,T,8,'ShowText','on')                     % Generate contour map from solution
figure, surf(Y,X,T)
%
% Nested function that applies the recursion relation
% 
    function tc=get_T_c(TT,ii,jj)
        % main SOR function
        xx=dx*(ii-1); yy=dx*(jj-1);
        tc=(TT(ii+1,jj)+TT(ii-1,jj)+TT(ii,jj+1)+TT(ii,jj-1))/4+1250*xx*yy*dx^2;
    end
end