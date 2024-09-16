V = 500; % ft3
D = 15; % ft
R = D / 2; % ft

f = @(h) pi .* h .^ 2 .* (3 .* R - h) - V .* 3;


%% graph
xx = 1:0.1:15;
hh = f(xx);

plot(xx, hh)

%% MATLAB solution

height = fzero(f, [5, 6]);
fprintf('Height of the liquid level to 3 sig figs: %.2f ft \n', height)