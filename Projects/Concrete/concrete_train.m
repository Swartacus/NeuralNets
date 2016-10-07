%concrete_train.m
%Author: Adam Swart
%Trains a neural network on the concrete benchmark dataset

clc; clear; close all

%import and encode data
p = xlsread('ConcreteData.xlsx','A2:H1031');
t = xlsread('ConcreteData.xlsx','I2:I1031');
p=p';t=t';

%Net architecture and training
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1 = 20;
s2 = 20;
s3 = 20;

net = newff(p,t,[s1,s2,s3]);

%training
net.trainFcn = 'trainscg';

%maxit
net.trainParam.epochs=1000;

% set the number of epochs that the error on the validation set increases
net.trainParam.max_fail=20;

%We can also set using:
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

% initiate
net=init(net);

% train
[net, netstruct]=train(net,p,t);

%name the net and structure
net.name = 'concrete';
concretenet = net;
concretestruct = netstruct;

%save variables
save cocnrete_train.mat