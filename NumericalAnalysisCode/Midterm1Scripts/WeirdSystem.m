N = 10;
S = 1000; % kg/h
W = 2000; % kg/h
Xin = 0.05;
Yin = 0;
K = 10;

A = zeros(N);
B = zeros([N,1]);

% First stage
A(1, 1) = -(1+K*S/W);
A(1, 2) = K*S/W;
B(1, 1) = -Xin;
A_entering = Xin * W;

% Middle Stages
for i=2:N-1
    A(i, i-1) = 1;
    A(i, i) = -(1+K*S/W);
    A(i, i+1) = K*S/W;
end

% Last stage
A(N, N-1) = 1;
A(N, N) = -(1+K*S/W);
B(N, 1) = -(S/W)*Yin;

x = A\B;
y = K.*x;
A_recovered = y(1) * S;

fprintf('Percent of A recovered = %3.10f', A_recovered / A_entering * 100)