%metal.m
%Author: Adam Swart
%trains a net on the metals.xls dataset
clc
clear
close all

data=xlsread('metals.xls');

x = [data(:,3:6), data(:,9:12), data(:,15:18), data(:,21:23), data(:,26:28),data(:,31:34), data(:,37:39), data(:,37:39)];

netlist = [];
for i=1:size(x,2)
    
    m = x(:,i);
    %rolling 5-day average of metal prices
    ac(1)=m(1);
    ac(2)=m(2);
    ac(3)=m(3);
    ac(4)=m(4);
    for j=5:size(m)
        ac(j)=(1/5)*sum(m(j:-1:j-4));
    end
    
    %slide window
    [p,t] = delay(ac,50);
    
    ptrain  = p(:,1:end-10);
    ptest   = p(:,end-9:end);

    ttrain  = t(1:end-10);
    ttest   = t(end-9:end);
    
    %layer sizes
    s1=10;
    s2=15;

    %network architecture
    net=newfftd(p,t,[s1,s2]);
   
    %Net training
    net.TrainParam.epochs=1000;
    net.divideFcn='divideind';
    %training
    net.trainFcn='trainscg';
    net.trainParam.max_fail=40;
    
    %Net training
    net.TrainParam.epochs=1000;

    %training
    net.trainFcn='trainscg';
    net.trainParam.max_fail=40;

    %initiate the weights and biases
    net=init(net);
    %train the net
    [net,tr]=train(net,ptrain,ttrain);
    %rename
    metnet=net;
    
    %activations
    atrain=sim(metnet,ptrain);
    atest=sim(metnet,ptest);
    a=sim(metnet,p);
    
    %degree of fit
    r2=rsq(ttest,atest)
    [R,pv]=corrcoef(ttest,atest);
    figure
    plot(ttest,ttest,ttest,atest,'*')
    title('test')
    figure
    hold on
    plot([1:length(atest)],ttest,'o')
    plot([1:length(atest)],atest,'*')
    hold off
    title(sprintf('activation on test set'))
    figure
    plot([1:length(a)],a,[1:length(a)],t,'o')
    title('activalion on all')
    
    netlist=[netlist metnet];
end

save metals_train.mat