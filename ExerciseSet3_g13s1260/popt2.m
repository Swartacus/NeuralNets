% Exercise 3.8.3 [1]
% pop2.m
% Iterative gradient descent
% Adam Swart

% get the starting point 
while true
    P = input('Starting point: P = ');
    if P(1) >= -1 && P(1) <= 1 && P(2) >= -1 && P(2) <= 1
        break
    else
        fprintf('Invalid starting point.\n');
    end
end

% set initial points
x1 = P(1);
x2 = P(2);

% define f
f = @(x1, x2) x1.^2 + x1.*x2 + x2.^2;

% define gradient function
g = @(x1, x2) [2*x1 + x2, 2*x2 + x1];

% define Hessian matrix
H = @(x1, x2) [2,1;1,2];

% define search direction v
v = @(x1,x2) -g(x1, x2)';

% define direction distance
alpha = @(x1,x2) -(g(x1,x2)*v(x1,x2))/(v(x1,x2)'*H(x1,x2)*v(x1,x2));

% set error function
E = f(x1,x2);

% gradient descent
i = 0;
while E(end) > 0 && i < 1000
    i = i+1;
    dx = alpha(x1(end),x2(end))*v(x1(end),x2(end));
    x1 = [x1, x1(end)+dx(1)];
    x2 = [x2, x2(end)+dx(2)];
    E = [E f(x1(end),x2(end))];
end

% plotting
hold on
[x,y] = meshgrid(-1:.01:1);
contour(x,y,f(x,y),20);
plot(x1,x2,'r');
hold off