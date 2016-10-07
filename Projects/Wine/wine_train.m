%wine_train.m
%Author: Adam Swart
%Trains a neural network on the wine dataset benchmark

clc;clear;close all

%import data
D = importdata('wine_data.txt');
p = D(:,2:14)';
t = D(:,1)';

%Net architecture and training
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1 = 5;
s2 = 5;

net = newff(p,t,[s1,s2]);

%training
net.trainFcn = 'trainlm';

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
net.name = 'wine';
winenet = net;
winestruct = netstruct;

%save variables
save wine_train.mat