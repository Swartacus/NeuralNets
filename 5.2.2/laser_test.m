%laser_test.m
%Author: Adam Swart
%Tests the net trained in laser_train.m

clc
clear
close all

load laser_train.mat

%training set
ptrain=p(:,lasernet.divideParam.trainInd);
atrain=sim(lasernet,ptrain);
ttrain=t(:,lasernet.divideParam.trainInd);

[atrain(:) ttrain(:)]

[r2 R]=correlation(atrain,ttrain,'train');

%test set
ptest=p(:,lasernet.divideParam.testInd);
atest=sim(lasernet,ptest);
ttest=t(:,lasernet.divideParam.testInd);
disp('atest ttest');
[atest(:) ttest(:)]
[r2 R]=correlation(atest,ttest,'test'); 

%entire set
aentire=sim(net,p);
disp('atest ttest');
[aentire(:) t(:)]
[r2 R]=correlation(aentire,t,'test'); 
%plots
figure
plot(ttest,ttest,ttest,atest,'.')
title('test')
figure
hold on
plot([1:length(atest)],ttest,'o')
plot([1:length(atest)],atest,'.')
hold off
title(sprintf('activation on test set'))
figure
plot([1:length(aentire)],aentire,[1:length(aentire)],t,'o')