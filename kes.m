function [ y ] = kes( x1, x2, sigma_f, l )

y = sigma_f^2 * exp((-norm(x1 - x2)^2) / (2*l^2));

end

