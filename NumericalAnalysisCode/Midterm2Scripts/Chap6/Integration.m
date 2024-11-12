%% Setup
dx=100;
xx=100:dx:1500;
ff=[40.06,43.48,46.41,48.90,50.99,52.73,54.15,55.32,56.26,57.03,57.67,...
    58.23,58.75,59.27,59.84];

%% Trapezoildal
intf=trapz(xx,ff);
disp(intf)

%% Simpsons Rule

intf=0;
for i=1:length(xx)
    if i==1 || i==length(xx)
        intf=intf+ff(i);
    elseif mod(i,2)==0
        intf=intf+4*ff(i);
    else
        intf=intf+2*ff(i);
    end
end
intf=intf*dx/3;
disp(intf)
