%interprbe1.m
%Author: Adam Swart
%Constructs RBF net and uses it to find a missing value

clc;clear;close all

%import data
p   = [0 1.0000 2.0000 3.0000 4.0000 5.0000 7.0000 8.0000 9.0000 10.0000];
t = [0 2.8962 4.8011 8.5094 9.6875 13.5910 12.8513 17.9356 16.2077 21.3635];

%test index
m = size(p,2);
I = randperm(m);
ti = I(1:floor(m/5))

%training index
tri = setdiff([1:m],ti);

%training and test sets:
ptrain = p(:,tri);
ttrain = t(:,tri);
ptest = p(:,ti);
ttest = t(:,ti);

d = dist(p',p);
dm = max(max(d))
fprintf('max distance between inputs = %4.2f\n',dm)


sr = [.1,6];

%use this procedure to find the best spread:
%matrix for storing spread and r
R = [];
for s = sr(1):0.1:sr(2)
    %train on training set
    net = newrbe(ptrain,ttrain,s);
    %simulate on test set
    atest = sim(net,ptest);
    [r2,r] = correlation(atest,ttest);
    R = [R;[s r2 r]];
end

disp('  spread      r2          r')
fprintf('%8.4f\t%-8.4f\t%-8.4f\n',R')

% find the best spread with r2 stat
[mr2,i]=max(R(:,2));
bs2=R(i,1);

% simulate with best spread
net = newrbe(ptrain,ttrain,bs2);
a   = sim(net,p);
[r2,r] = correlation(a,t);


% simulate on continuous data
pc = linspace(0,10,101);
ac = sim(net,pc);

% find the value at 6
six = sim(net,6);

%plot
figure
hold on
plot(p,t,'ob',pc,ac,'b',6,six,'*r');
hold off
title(sprintf('mixing s=%4.2f\n y(6)=%4.2f',bs2,six))
xlabel('targets')
ylabel('activation')