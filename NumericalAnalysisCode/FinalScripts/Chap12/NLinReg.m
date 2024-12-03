%% Video Example
% Using Langmuir isotherm

% experimental data
x = [0.5 0.387 0.24 0.136 0.04 0.011];
y = [1.255 1.25 1.189 1.124 0.783 0.402];

% nonlinear regression
f = @(pars,x) pars(1)*x./(pars(2)+x);
parguess = [1.3 0.03];
[pars,resid,J,CovB,MSE] = nlinfit(x,y,f,parguess);

fprintf('Use nlinfit function  \n')
fprintf('A is %1.4f \n',pars(1));
fprintf('B is %1.4f \n',pars(2));

% Finding confidence interval for fitting parameter
alpha = 0.05; % this is for a 95% confidence interval
pars_ci = nlparci(pars,resid,'jacobian',J,'alpha',alpha);
fprintf('A is in the range of [%1.4f %1.4f] at the 95% confidence level \n',pars_ci(1,:))
fprintf('B is in the range of [%1.4f %1.4f] at the 95% confidence level \n',pars_ci(2,:))

% Finding confidence interval for data prediction (y values)
xrange = min(x):.01:max(x);
[ypred,delta] = nlpredci(f,xrange,pars,resid,'Covar',CovB,'MSE',MSE,'alpha',alpha,'SimOpt','on');
lower=ypred-delta;
upper=ypred+delta;

% Plotting
% Plot experimental data
plot(x,y,'ko'); xlabel('x'); ylabel('y'); hold on;
% Plot regression curve
xfit = linspace(0.5, 0.011);
plot(xfit,f(pars,xfit),'DisplayName','fitted model')
legend show
% Plotting confidence interval curves
plot(xrange,[lower;upper],'r--','LineWidth',1.5)

%% Homework problem 1
% experimental data
T=[10,20,30,40,50,60,70];
mu=[1.308,1.005,0.801,0.656,0.549,0.469,0.406];

% Using linear regression to get a guess
% y=(1./mu)';
% x1 = T';
% x2 = (T.^2)';
% tbl=table(y,x1,x2,'VariableNames',{'y','x1','x2'});
% lm=fitlm(tbl,'y~x1+x2');
% disp(lm)

% nonlinear regression
f=@(pars,T) 1./(pars(1)+pars(2).*T+pars(3).*T.^2);
parguess = [0.5481,0.020485,9.8874e-5];
[pars,resid,J,CovB,MSE] = nlinfit(T,mu,f,parguess);

fprintf('k1 is %1.4f \n',pars(1));
fprintf('k2 is %1.4f \n',pars(2));
fprintf('k3 is %1.4f \n',pars(3));

% Finding confidence interval for fitting paramters
alpha = 0.05; % this is for a 95% confidence interval
pars_ci = nlparci(pars,resid,'jacobian',J,'alpha',alpha);
fprintf('k1 is in the range of [%1.4f %1.4f] at the 95%% confidence level\n',pars_ci(1,:))
fprintf('k2 is in the range of [%1.5f %1.5f] at the 95%% confidence level\n',pars_ci(2,:))
fprintf('k3 is in the range of [%1.5f %1.5f] at the 95%% confidence level\n',pars_ci(3,:))

%% Homework problem 2
T=[-183.1;-176.0;-169.6;-153.2;-140.0;-130.7;-124.1;];
T=T+273.15*ones(size(T)); % Convert unit to K
P=[1;2;5;10;20;30;40;]; % Unit: atm
% Need to get dependent term logged
LogP=log10(P);

f = @(pars,T) pars(1)-pars(2)./(pars(3)+T);
parguess = [3,200,-20];
[pars,resid,J,CovB,MSE] = nlinfit(T,LogP,f,parguess);

fprintf('A is %1.4f \n',pars(1));
fprintf('B is %1.4f \n',pars(2));
fprintf('C is %1.4f \n',pars(3));

% Finding confidence interval for fitting parameter
alpha = 0.05; % this is for a 95% confidence interval
pars_ci = nlparci(pars,resid,'jacobian',J,'alpha',alpha);
fprintf('A is in the range of [%1.4f %1.4f] at the 95%% confidence level \n',pars_ci(1,:))
fprintf('B is in the range of [%1.4f %1.4f] at the 95%% confidence level \n',pars_ci(2,:))
fprintf('C is in the range of [%1.4f %1.4f] at the 95%% confidence level \n',pars_ci(3,:))

% Finding confidence interval for data prediction (y values)
xrange = min(T):.01:max(T);
[ypred,delta] = nlpredci(f,xrange,pars,resid,'Covar',CovB,'MSE',MSE,'alpha',alpha,'SimOpt','on');
lower=ypred-delta;
upper=ypred+delta;

% Plotting
% Plot experimental data
plot(T,LogP,'ko'); xlabel('T'); ylabel('LogP'); hold on;
% Plot regression curve
xfit = linspace(min(T),max(T),100);
plot(xfit,f(pars,xfit),'DisplayName','fitted model')
legend show
% Plotting confidence interval curves
plot(xrange,[lower;upper],'r--','LineWidth',1.5)