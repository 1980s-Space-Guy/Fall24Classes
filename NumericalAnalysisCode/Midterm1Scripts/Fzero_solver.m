%% constants

%% Function
% remember to reformulate if variables are in the denominator
f=@(x)legendreP(6,x);

x=-1:0.001:1;
fx=zeros(1,length(x));
for i=1:length(x)
    fx(i)=f(x(i));
end
plot(x, fx)
ylim([-5,5])

%% Fzero solution 1
x0=[0.9,1];
sol1=fzero(f,x0);
disp(sol1)

%% Fzero solution 2
x0=[0.75,1.25];
sol2=fzero(f,x0);
disp(sol2)

%% Fzero solution 3
x0=[1.25,3];
sol3=fzero(f,x0);
disp(sol3)