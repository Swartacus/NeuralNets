% backprop1.m
% Author: Adam Swart
% Continues the updating process from example 4.3.2

clc
close all
clear all

%input pattern
p=[.5;.2;.1];

%target
t=[1.5;.8];

%initialize wights and biases randomly
W1=randu(0,1,2,3);
b1=randu(0,1,2,1);
W2=randu(0,1,2,2);
b2=randu(0,1,2,1);

f1=@tansig;
f2=@logsig;

%compute activations through the network
n1=W1*p+b1;
a1=f1(n1);
n2=W2*a1+b1;
a2=f2(n2);

%compute error
E(1)=sum((t-a2).^2);

% Train the net
h=input('learning rate h= ');
tolerance=0.3;
maxit=140;
i=2;

while(abs(E(i-1))>tolerance && i<maxit)    
    n1=W1*p+b1;
    a1=f1(n1);
    n2=W2*a1+b1;
    a2=f2(n2);
    
    %compute error
    E(i)=sum((t-a2).^2);
    
    %compute derivative matrices    
    D2=diag((1-a2).*a2);
    D1=diag(1-a1.^2);
    
    %compute sensitivities.
    S2=-2*D2*(t-a2);
    S1=D1*W2'*S2;

    %update weights and biases
    W2=W2-h*S2*a1';
    b2=b2-h*S2;
    W1=W1-h*S1*p';
    b1=b1-h*S2;
    
    %update counter    
    i= i+1;
end


%Plot
figure
plot(E);
xlabel('iterations');
ylabel('Errors');
title(sprintf('Performance with tolerance = %g\n',tolerance));



%Output
disp('E=');
disp(E');
pnew=input('simulate on new p = ');
n1=W1*pnew+b1;
a1=f1(n1);
n2=W2*a1+b1;
a2=f2(n2);
disp(pnew);
disp('the activation is:');
disp(a2);
plot((1:(k-1)),E);
xlabel('iterations');
ylabel('E');
title(sprintf('Performance with tolerance tol=%g',tol));