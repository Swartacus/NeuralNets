%ionosphere.m
%Author: Adam Swart
%Trains a net on the iondata.txt dataset

clc
clear
close all

data = importdata('iondata.txt');

p = [cos(2*pi*(data(:,1)/365)) sin(2*pi*(data(:,1)/365)) data(:,2) data(:,3)]';
t = data(:,4)';

% partition data sets
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);
%layer sizes
s1=13;
s2=12;

%create the net
net=newff(ptrain,ttrain,[s1,s2]);

%training
net.trainFcn='trainscg';

%maxit
net.trainParam.epochs=800;
net.trainParam.goal = 1e-6;

%set the number of epochs that the error on the validation set increases
net.trainParam.max_fail=20;

%We can also set using:
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

%initiate
net=init(net);

%train
[net,netstruct]=train(net,ptrain,ttrain);

net.userdata='ionosphere';
inet=net;
istruct=netstruct;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q1=size(ptrain,2);
%using our own hand-made net:
q2=size(ptest,2);
%simulate
atrain=sim(inet,ptrain); %train
atest=sim(inet,ptest);   %test
a=sim(inet,p);           %all

%degree of fit
disp('Train r and R values')
r2=rsq(ttrain,atrain)
[R,pv]=corrcoef(ttrain,atrain)

disp('Test r2')
r2=rsq(ttest,atest)
[R,pv]=corrcoef(ttest,atest)

%plot
x = 1:size(ttrain,2);
plot(x,ttrain,'bo',x,atrain,'r*');
xlabel('day')
ylabel('FoF2')
title('Training')
legend('Train Targets','Train Activations')
figure
x = 1:size(ttest,2);
plot(x,ttest,'bo',x,atest,'r*');
xlabel('day')
ylabel('FoF2')
title('Testing')
legend('Test Targets','Test Activations')