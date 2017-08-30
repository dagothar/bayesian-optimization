clc; clear all; close all;

%% Ground-truth function
%f = @(x) x + 0.5 * sin(15*x);
f = @(x) 0.25 * x - (0.5 * (x > 0.75) * x')';
x = [0 : 0.01 : 1];
y = f(x);

%% Kernel
kernel = @(x1, x2) kes(x1, x2, 0.8, 0.1);

%% Acquisition function
%af = @(x, m, v) rand(1);
kk = 2;
af = @(x, m, v, t) aq(x, m, v, kk, t);

%% Perform BO
t = [rand(1)];
z = [];

m = [];
v = [];

for i = 1:100
    
    z = f(t);
    [m, v] = gp(x, t, z, kernel);
    afy = af(x, m, v, t);
    
    
    cla;
    plot_gp(x, m, v, 0.995);
    hold on;
    plot(x, y, 'r');
    plot(t, z, 'ro');
    plot(x, afy, 'g');

    [M, I] = max(afy);
    nt = x(I);
    if any(t == nt)
        break
    end
    t = [t nt];
    
    nt
    f(nt)
    
    waitforbuttonpress
end