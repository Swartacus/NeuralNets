%school_test.m
%Author: Adam Swart
%Tests the net trained in school_train.m using the test data partition

clear all
close all
clc

%vary Swedish points
x(1,:)=linspace(24,46,100);
%vary school quality
x(2,:)= linspace(1,10,100);

%deploy the net
y = schoolnet(x);

%plots
figure
plot(x(2,:),y(1,:))
title('Final Mark vs School Quality')

figure
plot(x(1,:),y(1,:))
title('Final Mark vs Swedish points')