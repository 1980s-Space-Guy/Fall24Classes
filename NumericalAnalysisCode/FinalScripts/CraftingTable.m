%% Data
z=[0.051,0.101,0.156,0.194,0.253];
V=[15.8,21.08,24.8,26.99,30.25];

[dy]=differentiate(fittedmodel,0.12);
disp(dy)