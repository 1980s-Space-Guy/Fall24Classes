N = 15;
alpha=1;
beta=-2;
gamma=-2;

A = zeros(N);
B = zeros([N,1]);

% First stage
A(1, 1) = beta;
A(1, 2) = gamma;
B(1, 1) = 1;

% Middle Stages
for i=2:N-1
    A(i, i-1) = alpha;
    A(i, i) = beta;
    A(i, i+1) = gamma;
    B(i, 1) = 0;
end

% Last stage
A(N, N-1) = alpha;
A(N, N) = beta;
B(N, 1) = 1;

x = A\B;

disp(x)