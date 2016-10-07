%abalone_train.m
%Author: Adam Swart
%Trains a neural network on the abalone benchmark problem

clc; clear; close all

%import and encode data
D = fopen('abalone_data.txt');
data = textscan(D,'%c,%f,%f,%f,%f,%f,%f,%f,%f');
t = data{9}';
p = [];
for i = 1:size(data{1})
    if strcmp(data{1}(i),'M') == 1
        p(i,1) = 0;
    end
    if strcmp(data{1}(i),'F') == 1
        p(i,1) = 1;
    end
    if strcmp(data{1}(i),'I') == 1
        p(i,1) = 2;
    end    
end
p = [p data{2} data{3} data{4} data{5} data{6} data{7} data{8}]';

%Net architecture and training
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1 = 15;
s2 = 15;

net = newff(p,t,[s1,s2]);

%training
net.trainFcn = 'traincgp';

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
net.name = 'abalone';
abalonenet = net;
abalonestruct = netstruct;

%save variables
save abalone_train.mat
