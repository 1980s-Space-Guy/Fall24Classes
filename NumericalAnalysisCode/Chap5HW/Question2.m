function Question2
K1=1.93e-4;
K2=5.528;

% e1 is going to heavily favor reactants and be less than 2
e1_guess=0.1;

% e2 will be less than e2, but the reaction will moderately favor products
e2_guess=0.08;

options=optimset('Display', 'off');
[e_sol,~]=fsolve(@get_eqs,[e1_guess, e2_guess],options);
ee1=e_sol(1);
ee2=e_sol(2);

fprintf('Carbon Monoxide Fraction: %1.4f\n', (ee1-ee2)/(10+2*ee1))
fprintf('Hydrogen Fraction: %1.4f\n', (3*ee1+ee2)/(10+2*ee1))
fprintf('Water Fraction: %1.4f\n', (8-ee1-ee2)/(10+2*ee1))
fprintf('Carbon Dioxide Fraction: %1.4f\n', (ee2)/(10+2*ee1))
fprintf('Methane Fraction: %1.4f\n', (2-ee1)/(10+2*ee1))

function rxn_eqs=get_eqs(x)
    % x(1) is e1, x(2) is e2
    e1 = x(1); e2 = x(2);
    % These need to be equal to zero
    rxn_eqs(1,1)=(e1-e2)*(3*e1+e2)^3-K1*(2-e1)*(8-e1-e2)*(10+2*e1)^2;
    rxn_eqs(2,1)=e2*(3*e1+e2)-K2*(e1-e2)*(8-e1-e2);
end
end