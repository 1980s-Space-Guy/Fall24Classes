% all have units of 1/s
kab = 0.1;
kba = 0.02;
kbc = 0.5;
kcb = 0.1;
kcd = 0.01;
kdc = 0.1;
kda = 0.05;
kad = 0.2;
kbd = 0.3;
kdb = 0.1;

A = [-kab-kad, kba, 0, kda;...
     kab, -kba-kbc-kbd, kcb, kdb;...
     0, kbc, -kcb-kcd, kdc;...
     kad, kbd, kcd, -kda-kdc-kdb;...
     1, 1, 1, 1];

B = [0; 0; 0; 0; 1];


x = A\B;

fprintf('Species Concentrations (gmol/Liter) \n')
fprintf('A: %f \n', x(1))
fprintf('B: %f \n', x(2))
fprintf('C: %f \n', x(3))
fprintf('D: %f \n', x(4))

