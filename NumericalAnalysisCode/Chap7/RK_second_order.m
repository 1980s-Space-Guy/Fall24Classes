%% System ODE Exercise
L=2;
V1=10;
V2=5;
dC1dt=@(t,C1,C2) -L/V1*C1;
dC2dt=@(t,C1,C2) -L/V2*(C2-C1);

t(1)=0;
C1(1)=0.3;
C2(1)=0;

n=1;
tf=0.5;
dx=(tf-t(1))/n;

for i=1:n
    t(i+1)=t(i)+dx; %#ok<SAGROW>
    k11=dx*dC1dt(t(i),C1(i),C2(i));
    k12=dx*dC2dt(t(i),C1(i),C2(i));

    k21=dx*dC1dt(t(i)+1/2*dx,C1(i)+1/2*k11,C2(i)+1/2*k12);
    k22=dx*dC2dt(t(i)+1/2*dx,C1(i)+1/2*k11,C2(i)+1/2*k12);

    C1(i+1)=C1(i)+k21; %#ok<SAGROW>
    C2(i+1)=C2(i)+k22; %#ok<SAGROW>
end

plot(t, C1); hold on;
plot(t, C2)