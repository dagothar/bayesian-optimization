clc; clear all; close all;

%% Ground-truth function
f = @(x) x + 0.5 * sin(17*x) + 0.05*randn(1);
%f = @(x) 0.25 * x - (0.5 * (x > 0.75) * x')';
x = [0 : 0.01 : 1];
y = f(x);

%% Kernel
kernel = @(x1, x2) kes(x1, x2, 1, 0.05);

%% Acquisition function
%af = @(x, m, v) rand(1);
kk = 2;
af = @(x, m, v, t) aq(x, m, v, kk, t);

%% Perform BO
t = [rand(1)];
z = f(t);

m = [];
v = [];
Q = 0;

for i = 1:1000
    
    [m, v] = gp(x, t, z, kernel, 0.2);
    afy = af(x, m, v, t);
    
    
    cla;
    plot_gp(x, m, v, 0.995);
    hold on;
    plot(x, y, 'r');
    plot(t, z, 'ro');
    plot(x, afy, 'g');
    ylim([-1 2.5]);

    [M, I] = max(afy);
    nt = x(I);
    if any(t == nt)
        %nt = rand(1);
        disp('!');
    end
    t = [t nt];
    
    Y = f(nt);
    z = [z Y];
    if Y > Q
        nt
        Q = Y
    end
    
    pause
end