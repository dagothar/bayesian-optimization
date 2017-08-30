clc; clear all; close all;

%% Construct kernel
kernel = @(x1, x2) kes(x1, x2, 1, 0.5);

%% Create and evaluate the function
t = [-1 : 0.05 : 1];
[X, Y] = meshgrid(t, t);
Z = 0.25*myfun(X, Y);
f = @(x) 0.25*myfun(x(1), x(2));

%% Data points
x = [
    0 0;
    %-1 -1;
    %1 1;
    %0.25 1;
    %0.75 0;
    ]';
y = [];

for i = 1 : size(x, 2)
    y = [y f(x(:, i))];
end


for k = 1:100
    %% Construct the prior
    M = zeros(size(X));
    V = zeros(size(X));

    for i = 1:size(M, 1)
        for j = 1:size(M, 2)
            X(i, j);
            Y(i, j);
            [M(i, j) V(i, j)] = gp2([X(i, j) Y(i, j)]', x, y, kernel);
        end
    end

    U = M+erfinv(0.99)*V;

    %% Plot
    scatter3(x(1, :), x(2, :), y, 'k*');
    hold on;
    
    h = surf(X, Y, Z);
    set(h, 'facecolor', 'red');
    set(h, 'facealpha', 0.75);

    h = surf(X, Y, M);
    set(h, 'facecolor', 'blue');
    set(h, 'facealpha', 0.5);
    set(h, 'edgecolor', 'none');

    h = surf(X, Y, M-V);
    set(h, 'facecolor', 'yellow');
    set(h, 'facealpha', 0.25);
    set(h, 'edgecolor', 'none');

    h = surf(X, Y, M+V);
    set(h, 'facecolor', 'yellow');
    set(h, 'facealpha', 0.25);
    set(h, 'edgecolor', 'none');

    h = surf(X, Y, U);
    set(h, 'facecolor', 'green');
    set(h, 'facealpha', 0.25);
    set(h, 'edgecolor', 'none');
    hold off;
    
    % find the maximum of U
    [xx, I] = max(U);
    [yy, J] = max(xx);
    %I, J
    nx = [X(I(J), J) Y(I(J), J)];
    for i = 1 : size(x, 2)
        if x(:, i) == nx'
            disp('ups')
            nx = 2 * rand(1, 2) - 1;
        end
    end
    x = [x nx'];
    y = [y f(nx)];
    
    nx, f(nx)
    
    pause;
end