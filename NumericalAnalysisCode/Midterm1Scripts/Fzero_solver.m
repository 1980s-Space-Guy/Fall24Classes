%% constants
a=5.536;
b=0.03049;
T=300;
R=0.08205746;
P=3;

%% Function
% remember to reformulate if variables are in the denominator
f=@(x) x*tan(x)-1;

x=-6*pi:0.05:3*pi;
fx=zeros(1,length(x));
for i=1:length(x)
    fx(i)=f(x(i));
end
plot(x, fx)
ylim([-5,5])

%% Fzero solution 1
x0=[-1.25,-0.75];
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