function [ m, v ] = gp2( t, x, y, kernel )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

K = zeros(size(x, 2));
Kstar = zeros(1, size(x, 2));

m = [];
v = [];

    for i = 1:size(x, 2)
        for j = 1:size(x, 2)
            K(i, j) = kernel(x(:, i), x(:, j));
        end

        Kstar(i) = kernel(t, x(:, i));
    end

    m = Kstar * inv(K) * y';
    v = K(1, 1) - Kstar * inv(K) * Kstar';

end

