heat_of_reaction = -890.4; %kJ/gmol
enthalpy_absorbed = heat_of_reaction * -1; %kJ/gmol
enthalpy_absorbed = enthalpy_absorbed * 1000; %J/gmol

inital_temperature = 50; %C

% Carbon Dioxide
heat_capacities(1, 1) = 36.11;
heat_capacities(1, 2) = 4.233 * 10 ^ -2;
heat_capacities(1, 3) = -2.887 * 10 ^ -5;
heat_capacities(1, 4) = 7.464 * 10 ^ -9;

% Water Vapor
heat_capacities(2, 1) = 33.46;
heat_capacities(2, 2) = 0.688 * 10 ^ -2;
heat_capacities(2, 3) = 0.7604 * 10 ^ -5;
heat_capacities(2, 4) = -3.593 * 10 ^ -9;

% Nitrogen
heat_capacities(3, 1) = 29.00;
heat_capacities(3, 2) = 0.2199 * 10 ^ -2;
heat_capacities(3, 3) = 0.5723 * 10 ^ -5;
heat_capacities(3, 4) = -2.871 * 10 ^ -9;

moles_O2 = 3;
moles_N2 = moles_O2 / .21 * .79;
moles_CO2 = 1;
moles_H2O = 2;

syms T Ta
for i = 1:size(heat_capacities, 1)
    heat_capacity_eq = heat_capacities(i, 1) + T * heat_capacities(i, 2)...
        + T ^ 2 * heat_capacities(i, 3) + T ^ 3 * heat_capacities(i, 4);
    integrals(i) = int(heat_capacity_eq, T, inital_temperature, Ta); %#ok<SAGROW>
end

H_Gas = moles_CO2 * integrals(1) + moles_H2O * integrals(2) + moles_N2...
    * integrals(3) - enthalpy_absorbed;

TT = solve(H_Gas==0, Ta);
vpa(TT)