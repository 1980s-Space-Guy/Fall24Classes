%% Constants and Equations
Q=2.5; % L/s
Q=Q/1000; % m3/s
L=15; % m
DeltaPMax=103; % kPa
DeltaPMax=DeltaPMax*1000; % Pa

fDeltaP=@(fF,rho,L,v,D) 2*ff*rho*L*v^2/D;
fv=@(Q,D) 4*Q/(pi*D^2);
ffFL=@(Re) 16/Re;
frhoW=@(T) 46.048+T*(9.418+T*(-0.0329+T*(4.882e-5-2.895e-8*T)));
fmu=@(T) exp(-10.547+541.69/(T-144.53));
fRe=@(D,v,rho,mu) D*v*rho/mu;

%% D test
D=0.2; % m
T=25; % Celsius
T=T+273.15; % K

rhoW=frhoW(T);
v=fv(Q,D);
mu=fmu(T);
Re=fRe(D,v,rhoW,mu);
disp(Re)
fF_range=-0.1:0.00001:0.01;
yy=zeros(size(fF_range));
fF_fzero_function=@(fF_guess) fF_guess-1/(4*log10(Re*sqrt(fF_guess))-0.4)^2;
for i=1:length(fF_range)
    yy(i)=fF_fzero_function(fF_range(i));
end
plot(fF_range, yy)


%% Part A
function val=Diameter_fzero(D)
    T=25; % Celsius
    T=T+273.15; % K
    Q=2.5; % L/s
    Q=Q/1000; % m3/s
    L=15; % m
    DeltaPMax=103; % kPa
    DeltaPMax=DeltaPMax*1000; % Pa

    rhoW=frhoW(T);
    v=fv(Q,D);
    mu=fmu(T);
    Re=fRe(D,v,rhoW,mu);
    if Re<2100
        fF=ffFL(Re);
    else
        fF_fzero_function=@(fF_guess) fF_guess-1/(4*log10(Re*sqrt(fF_guess))-0.4)^2;
        options=optimset('Display', 'off');
        fF=fzero(fF_fzero_function, [0.0001, 0.1], options);
    end
    val=DeltaPMax-2*fF*rhoW*L*v^2/D;   
end

diameter_range=0.01:0.0001:0.3;
yy=zeros(size(diameter_range));
for i=1:length(diameter_range)
    yy(i)=Diameter_fzero(diameter_range(i));
end
%plot(diameter_range, yy)

options=optimset('Display', 'off');
part_a_sol=fzero(@Diameter_fzero, [0.024,0.028], options); % solution in m

fprintf('The diameter of the pipe at 103 kPa is %0.4f inches\n', part_a_sol*39.3701)

%% Part B
fprintf('For a Diameter of 1.0327 inches, you should choose the 1 in nominal pipe size\n')

%% Part C
function pressure_drop=Temperature_Function(T)
    T=T+273.15; % K
    Q=5; % L/s
    Q=Q/1000; % m3/s
    L=16; % m
    D_outside=1.66; % in
    wall_thickness=0.14; % in
    D_inside=D_outside-2*wall_thickness; % in
    D_inside=D_inside/39.3701; % m

    rhoW=frhoW(T);
    v=fv(Q,D_inside);
    mu=fmu(T);
    Re=fRe(D_inside,v,rhoW,mu);
    if Re<2100
        fF=ffFL(Re);
    else
        fF_fzero_function=@(fF_guess) fF_guess-1/(4*log10(Re*sqrt(fF_guess))-0.4)^2;
        options=optimset('Display', 'off');
        fF=fzero(fF_fzero_function, [0.0001, 0.1], options);
    end
    pressure_drop_Pa=2*fF*rhoW*L*v^2/D_inside; % Pa
    pressure_drop = pressure_drop_Pa/1000; %kPa
end

Temp_range=5:0.01:80;
pressure_drops=zeros(size(Temp_range));
for i=1:length(Temp_range)
    pressure_drops(i)=Temperature_Function(Temp_range(i));
end
plot(Temp_range, pressure_drops)
fprintf('Lowest Pressure Drop: %3.3f kPa\n', pressure_drops(end))
fprintf('Highest Pressure Drop: %3.3f kPa\n', pressure_drops(1))

%% Part D
function val=Temperature_fzero(T)
    T=T+273.15; % K
    Q=5; % L/s
    Q=Q/1000; % m3/s
    L=16; % m
    D_outside=1.66; % in
    wall_thickness=0.14; % in
    D_inside=D_outside-2*wall_thickness; % in
    D_inside=D_inside/39.3701; % m
    DeltaPMax=103; % kPa
    DeltaPMax=DeltaPMax*1000; % Pa

    rhoW=frhoW(T);
    v=fv(Q,D_inside);
    mu=fmu(T);
    Re=fRe(D_inside,v,rhoW,mu);
    if Re<2100
        fF=ffFL(Re);
    else
        fF_fzero_function=@(fF_guess) fF_guess-1/(4*log10(Re*sqrt(fF_guess))-0.4)^2;
        options=optimset('Display', 'off');
        fF=fzero(fF_fzero_function, [0.0001, 0.1], options);
    end
    val=DeltaPMax-2*fF*rhoW*L*v^2/D_inside;
end

options=optimset('Display', 'off');
part_d_sol=fzero(@Temperature_fzero, [8,12], options); % Solution in Celsius
fprintf('Minimum Temperature: %1.3f degrees Celsius\n', part_d_sol)