%numbers_train.m
%Author: Adam Swart
%Extends the numbers scripts to identify numbers 0:9

clc;clear;close all

load numbersdata.mat

%initialisation
P = [ number_0(:) number_1(:) number_2(:) number_3(:) number_4(:) number_5(:) number_6(:) number_7(:) number_8(:) number_9(:)];

p = repmat(P,1,25);

%better to use unordered targets
T=eye(size(P,2));
t = repmat(T,1,25);

%create net
net=newff(p,t,[30, 30]);
net.divideFcn='';

%set goal>0
net.trainParam.goal=1e-8;
net=init(net);
[net,tr]=train(net,p,t);

numnet=net;

save numbers.mat