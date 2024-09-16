Qdot_A = 850; % Btu/h-ft2
h = 1.0; % Btu/h-ft2-deg. F
e = 0.9;
s = 1.174e-9; % Btu/h-ft2-R4

% Since I don't know if the temps should be in Fahrenheit or Rankine, I'll 
% give you both

%% Fahrenheit
TsurrF = 100; % deg. F
fF = @(T) h .* (T - TsurrF) + e .* s .* (T .^ 4 - TsurrF .^ 4) - Qdot_A;

TT = 32:0.5:2000;
ff = fF(TT);
%plot(TT, ff)

Surface_TempF = fzero(fF, [600, 700]);
fprintf('Surface Temp if the temps in the equation should have been in Fahrenheit \n')
fprintf('%.1f deg. F \n', Surface_TempF)

%% Rankine
TsurrR = 100 + 459.67; % R
fR = @(T) h .* (T - TsurrR) + e .* s .* (T .^ 4 - TsurrR .^ 4) - Qdot_A;

TT = 492:0.5:2500;
ff = fR(TT);
%plot(TT, ff)

Surface_TempR = fzero(fR, [800, 900]);
fprintf('Surface Temp if the temps in the equation should have been in Rankine \n')
fprintf('%.1f R \n', Surface_TempR)