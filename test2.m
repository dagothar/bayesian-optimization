clc; clear all; close all;

%% Generate data
x = [0 1 2 3 4 ];
y = sin(x);

%% Make kernel
kernel = @(x1, x2) kes(x1, x2, 10, 1);

%% Gaussian process
t = [0:0.1:4];
k = erfinv(0.99);
[m, v] = gp(t, x, y, kernel);

%% Plot the result
figure;
plot_gp(t, m, v, 0.995);