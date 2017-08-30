function [ output_args ] = plot_gp( x, mean, variance, alpha )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

plot(x, mean, 'b');
hold on;
X = [x fliplr(x)];
k = erfinv(alpha);
l_bound = mean - variance * k;
u_bound = mean + variance * k;
Y = [l_bound fliplr(u_bound)];
h = fill(X, Y, 'b');
set(h, 'facealpha', .1);
set(h, 'edgecolor', 'none');
hold off;

end

