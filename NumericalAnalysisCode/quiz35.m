a = 5.536; % L2 atm / mol2
b = 0.03049; % L / mol
R = 0.08205746; % L atm / K mol
T = 300; % K
P = 3; % atm
VanDerWaals = @(V) -R * T + (P + a / V^2) * (V - b);
bounds = [0.01, 0.1];

liq_sol = fzero(VanDerWaals, bounds);
disp(liq_sol)
 