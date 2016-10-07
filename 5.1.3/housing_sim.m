%housing_sim.m
%Author: Adam Swart
%Deploys housing_fcn to determine the value of houses with attributes
%in the dataset pnew
clear
close all
clc

pnew = importdata('housing_pnew.txt');
A=housing_fcn(pnew);
disp('Value of houses from housing_pnew:')
disp(A)