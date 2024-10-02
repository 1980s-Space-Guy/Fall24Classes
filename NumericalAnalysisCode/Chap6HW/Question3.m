%% Initializing Data
T=100:100:1500;
Cp=[40.06,43.48,46.41,48.9,50.99,52.73,54.15,55.32,56.26,57.03,57.67,58.23,58.75,59.27,59.84];

%% Part A
Tint=trapz(T,Cp);

fprintf('Using TrapezoidsThe change in enthalpy from 100 Degrees Celsius to 1500 degrees Celsius is %5.0f J/gmol\n', Tint)

%% Part B
Sint=0;
for i=1:length(T)
    if i==1
        Sint=Sint+Cp(i);
    elseif i==length(T)
        Sint=Sint+Cp(i);
    elseif mod(i,2)==0
        Sint=Sint+4*Cp(i);
    else
        Sint=Sint+2*Cp(i);
    end
end

fprintf('Using Simpsons Rule, The change in enthalpy from 100 Degrees Celsius to 1500 degrees Celsius is %5.0f J/gmol\n', Sint*100/3)