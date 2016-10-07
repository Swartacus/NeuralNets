%alphabet.m
%Author: Adam Swart
%Pattern recognition on the alphabet dataset

clc;clear;close all

%input
[P,T] = prprob;

p   = repmat(P,1,25);

%disturb data
r   = randi([1,size(P,1)],1,size(p,2)-size(P,2));

for i = size(P,2)+1:size(p,2)
    if p(r(i-size(P,2)),i) == 0
        p(r(i-size(P,2)),i) = 1;
    else
        p(r(i-size(P,2)),i) = 0;
    end
end

%targets
t = repmat(T,1,25);


%create net
net=newff(p,t,[30, 30]);
net.divideFcn='';

%set goal>0
net.trainParam.goal=1e-8;
net=init(net);
[net,tr]=train(net,p,t);
alphnet=net;



save alphabet.mat