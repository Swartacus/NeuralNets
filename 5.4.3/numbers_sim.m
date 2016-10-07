%numbers_sim.m
%Author: Adam Swart
%simulates numnet on corrupted numbers in the file numbersdata.m

clc;clear;close all
load numbers.mat

P = input('P = ');
P=P(:);
a = sim(numnet,P);

%find the number closest to a:
for j = 1:size(p,2)
    d(j) = norm(a-t(:,j));
end

[m,k] = mind(d);

fig = zeros(30,1);

switch k
    case 1
        fig=number_0;
    case 2
        fig =number_1;
    case 3
        fig =number_2;
    case 4
        fig=number_3;
    case 5
        fig =number_4;
    case 6
        fig =number_5;
    case 7
        fig=number_6;
    case 8
        fig =number_7;
    case 9
        fig =number_8;
    case 10
        fig=number_9;
end

P = reshape(P,6,5);
figure
spy(P)
P=num2str(P);

disp('input pattern:')
P

fig = reshape(fig,6,5);
spy(fig)

fig = num2str(fig);

disp('identified as:')
fig