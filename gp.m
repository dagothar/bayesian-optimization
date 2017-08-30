function [ m, v ] = gp( t, x, y, kernel, sn )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

K = zeros(length(x));
Kstar = zeros(1, length(x));

m = [];
v = [];

for k = 1:length(t)
    for i = 1:length(x)
        for j = 1:length(x)
            K(i, j) = kernel(x(i), x(j));
        end
        
        K(i, i) = K(i, i) + sn^2;

        Kstar(i) = kernel(t(k), x(i));
    end

    m = [m Kstar * inv(K) * y'];
    v = [v K(1, 1) - Kstar * inv(K) * Kstar'];
end

end

