% Exercise 3.8.3 [3]
% nlrgd.m
% Finds coefficients for regression function y = Asin(tk)
% Adam Swart

% initialise data points
clear all
t = 0:10;
y = [0 2.67 -2.32 -0.80 2.98 -1.55 -1.61 2.83 -0.86 -2.35 2.87];
x = [3.3, 2.2]';

% set function
f = @(x,t) x(1).*sin(x(2).*t);

% set gradient
g = @(x,t) [2*(x(1).*sin(x(2).*t) - y).*sin(x(2).*t); 2*(x(1).*sin(x(2).*t) - y).*t.*x(1).*cos(x(2).*t)];

% set error function and learning rate
E = sum((f(x,t) - y).^2);
a = .01;
i = 2;

% gradient descent
while E > sqrt(a)
    x = x - (a/sqrt(i))*(sum(g(x,t),2)./length(t));
    E = sum((f(x,t) - y).^2);
    i = i+1;
end

%plotting
hold on
plot(t,y,'o');
plot([0:.01:10],f(x,[0:.01:10]));
hold off
