%iris_train.m
%Author: Adam Swart
%Trains a neural network on the iris benchmark dataset

clc; clear; close all

%import data
D = fopen('iris_data.txt');
data = textscan(D,'%f,%f,%f,%f,%s');
P = [data{1} data{2} data{3} data{4}]';
T = data{5}';
%encode data
p=P;
t=[];
for i = 1: size(T,2)
    if strcmp(T(1,i),'Iris-setosa') == 1
        t = [t, 0];
    end
    if strcmp(T(1,i),'Iris-versicolor') == 1
        t = [t, 1];
    end
    if strcmp(T(1,i),'Iris-virginica') == 1
        t = [t, 2];
    end
end


%Net architecture and training
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1 = 2;
s2 = 2;

net = newff(p,t,[s1,s2]);

%training
net.trainFcn = 'trainscg';

%maxit
net.trainParam.epochs=10000;

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
net.name = 'iris';
irisnet = net;
irisstruct = netstruct;

%save variables
save iris_train.mat