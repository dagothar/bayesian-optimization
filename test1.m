clc; clear all; close all;

sigma_f = 1.1;
sigma_n = 0.01;
l = 1.0;

f = @(x1, x2) kernel(x1, x2, sigma_f^2, sigma_n^2, l);

%% Data
x = [0 1 2 3 4];
y = [0 0.2 0.75 0.25 0];

%% COnstruct kernel matrix
K = zeros(length(x))
for i = 1:length(x)
    for j = 1:length(x)
        K(i, j) = f(x(i), x(j));
    end
end

%% Calculate regressed mean and variance bounds
f = @(x1, x2) kernel(x1, x2, sigma_f^2, 0, l);
t = [0:0.01:4];
s = [];
v = [];
for i = 1:length(t)
    Kstar = [];
    for j = 1:length(x)
        Kstar = [Kstar f(t(i), x(j))];
    end
    
     Kstar
%     inv(K)
%     y
    
    s = [s Kstar * inv(K) * y'];
    v = [v K(1, 1) - Kstar * inv(K) * Kstar'];
end

u = s - 1.96 * sqrt(v);
w = s + 1.96 * sqrt(v);

%% Calculate acquisition function
k1 = 1.0;
k2 = 1.0;
a = k1* s - k2 * v;

%% Plot the results
figure;
plot(x, y); hold on;
plot(t, s);
plot(t, u);
plot(t, w);

plot(x, y)

%plot(t, a);