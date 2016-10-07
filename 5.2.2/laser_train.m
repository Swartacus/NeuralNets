%laser_train.m
%Author: Adam Swart
%trains a net on the laser.mat dataset
clc
clear
close all

load laser.mat

[p,t]=delay(y',8);
m=size(p,2);


s1=2;
s2=2;

%network architecture
net=newff(p,t,[s1,s2]);

%size of test set: the last n
n=10;
%ttest index
ti=[m-n:m];

%training index
tri=[1:m-n-1];

%val index
vi=[];

net.divideFcn='divideind';
net.divideParam.trainInd=tri;
net.divideParam.testInd=ti;
net.divideParam.valInd=[];

%Net training
net.TrainParam.epochs=1000;

%training
net.trainFcn='trainscg';
net.trainParam.max_fail=40;

%initiate the weights and biases
net=init(net);

%train the net
[net,tr]=train(net,p,t);

%rename
lasernet=net;

save laser_train.mat