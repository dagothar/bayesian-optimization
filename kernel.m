function [ y ] = kernel( x1, x2, var_f, var_n, l )

y = var_f * exp((-(x1 - x2)^2) / (2*l^2));

if x1 == x2
    y = y + var_n;
end

end

