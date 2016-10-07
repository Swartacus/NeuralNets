%mushroom_train.m
%Author: Adam Swart
%Trains a net on the mushroom classification benchmark dataset

clc; clear; close all

%import data
data   = fopen('mushroom_data.data');
data = textscan(data,'%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c');
P = [data{2} data{1} data{3} data{4} data{5} data{6} data{7} data{8} data{9} data{10} data{11} data{12} data{13} data{14} data{15} data{16} data{17} data{18} data{19} data{20} data{21} data{22} data{23}]';
T = data{1}';

%encode data
for i = 1:size(P,2)
    for j = 1:size(P,1)
        pi(j,i) = double(P(j,i)) - 97;
    end
    if T(i) == 'e'
        ti(i) = 1;
    end
    if T(i) == 'p'
        ti(i) = 0;
    end
    if (T(i) ~= 'p') && (T(i) ~= 'e')
        ti(i) = -1;
    end
end
p = [];
t = [];
%remove missing entries
for i = 1:size(pi,2)
    a = find(pi(:,i)<0);
    b = find(ti(:,i)<0);
    if (isempty(a)) || (isempty(b))
        p = [p, pi(:,i)];
        t = [t, ti(:,i)];
    end
end

%Net architecture and training
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1 = 20;
s2 = 10;

net = newff(p,t,[s1,s2]);

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
net.name = 'mushrooms';
mushroomnet = net;
mushroomstruct = netstruct;

%save variables
save mushroom_train.mat
