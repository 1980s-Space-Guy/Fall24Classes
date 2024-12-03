%% Video Example
milk=[1; 4; 1; 3; 2; 4;];
food=[1; 8; 3; 5; 6; 10;];
weight=[2; 8; 1; 7; 4; 6;]; weight=100*weight;

% The first dataset given is the independent variable
% all others afterward are dependent variables
tbl=table(milk,food,weight,'VariableNames',{'milk','food','weight'});

% Lower P values are better
% A p-value of 0.05 is 95% significant
% Both of the parameters given are very significant
lm=fitlm(tbl,'milk~weight+food');
disp(lm)

%% Quiz Problem
literacy_rate=[0.98;0.93;0.25;0.99;0.79;0.72;0.32;0.99;0.99;0.82];
newspapers=[280;142;10;391;86;17;21;314;333;91];
radios=[266;230;114;313;329;42;49;1695;430;182];
tv_sets=[228;201;2;227;82;11;16;472;185;89];

tbl=table(literacy_rate,newspapers,radios,tv_sets,'VariableNames',{'LR','NP','RA','TV'});
lm=fitlm(tbl,'LR~NP+RA+TV');
disp(lm)

% Predicting literacy rate for question 2
disp(0.51486+5.4206e-4*200+-3.5346e-4*800+1.9882e-3*250)