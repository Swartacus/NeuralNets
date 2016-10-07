%concrete_test.m
%Author: Adam Swart
%Tests a neural network trained in concrete_train.m

clc; clear; close all

load cocnrete_train.mat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q1 = size(ptrain,2);
%using our own hand-made net
q2 = size(ptest,2);

%simulate
atrain=sim(concretenet,ptrain); %train
atest = sim(concretenet,ptest); %test
a = sim(concretenet,p);         %all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%assessing the degree of fit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%train
r2=rsq(ttrain,atrain);
[R,PV]=corrcoef(ttrain,atrain);

fprintf('Testing:\n\n')
fprintf('  corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2);
disp('-------------------------------------------------------------')

figure
plot(ttrain,ttrain,ttrain,atrain,'*')
title(sprintf('training: With %g samples \n',q1))

% test:
r2=rsq(ttest,atest);
[R,PV]=corrcoef(ttest,atest);

fprintf('Testing: \n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
disp('----------------------------------------------------------------------')

figure
plot(ttest,ttest,ttest,atest,'*')
title(sprintf('Testing: With %g samples \n',q2))

% all
r2=rsq(t,a);
[R,PV]=corrcoef(t,a);
fprintf('Testing:\n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
disp('----------------------------------------------------------------------')
figure
plot(t,t,'bo',t,a,'r*')
title(sprintf('Testing: With %g samples \n',q1+q2))
figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MATLAB post regression functions
r=postreg(a,t);
rtest=postreg(atest,ttest);
rtrain=postreg(atrain,ttrain);

disp('MATLAB postregression')
disp('-----------------------')
fprintf('train r=%g\n',rtrain)
fprintf('test r=%g\n',rtest)
fprintf('all r=%g\n',r)

% %MATLAB regression plotting functions:
 plotregression(ttest,atest)
 title('test')
 plotregression(t,a)
 title('train')
 plotregression(t,a)
 title('all')

%MATLAB performanc plots
plotperform(netstruct)

%save all variables
save cocnrete_test.mat