x = pi/6;
func=@(x) sin(x);
Taylor=@(n) (-1)^n/factorial(2*n+1)*x^(2*n+1);

terms=3;
sum=0;
for i=0:terms-1
    sum = sum + Taylor(i);
end

fprintf('%2.8f\n', sum)

fprintf('%2.8f\n', abs(sum - func(x)))