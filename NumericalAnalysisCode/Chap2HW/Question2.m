pi_power_term = @(index) (-3)^(-index) / (2 * index + 1);

current_estimate = 1;
current_sum = 0;
k = 0;
last_term = 1;

while abs(last_term / current_estimate) >= 10 ^ -8
    last_term = pi_power_term(k);
    current_sum = current_sum + pi_power_term(k);
    k = k + 1;
    current_estimate = sqrt(12) * current_sum;
end

fprintf('Pi estimation: %.8f\n', current_estimate)