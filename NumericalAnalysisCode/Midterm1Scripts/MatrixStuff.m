%% Basic Matricies
A=[3,2,1;...
   6,4,3;...
   1,5,2];

B=[2,1,1;...
   2,1,3;
   1,3,1];

%% Display matrix value
fprintf('%f\n', A(2,3))

%% Transpose Matrix
disp(transpose(A))

%% Add Matrix
C=A+B;
disp(C)

%% Matrix Multiplication
D=A*B;
disp(D)

%% More ways of creating Maticies
E=1:2:9;
%linspace returns a vector of start, end, number of values
F=[linspace(10,50,5)];
G=[3,2,1,5,4];
H=[E;F;G];
disp(H)

%% Display multiple values in a Matrix
disp(H(2:3, 4:5))