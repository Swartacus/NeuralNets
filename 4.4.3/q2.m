%q2.m
%Author: Adam Swart
% Deploys ugradnet to investigate 
% (a) - Semester marks versus school quality & Swedish points for
% a fixed test mark of 50
% (b) - Semester marks versus school quality and test marks for a fixed
% Swedish point score of 30
% (c) - Test mark that should be obtained to pass both semesters for 
% a student who comes from a school of quality 6 and has Swedish point 
% score of 25

clear all 
close all
clc 

load ugrad_train.mat

%% (a) 
%vary Swedish points
xa(1,:)=linspace(24,46,91);
%vary school quality
xa(2,:)=linspace(1,10,91);
%fixed test mark
xa(3,:)=repmat(50,1,91);

%deploy the net
ya=ugradnet(xa);

%plots
figure
plot(xa(2,:),ya(1,:));
title('Semester 1 vs school quality for fixed test mark of 50');

figure
plot(xa(2,:),ya(2,:));
title('Semester 2 vs school quality for fixed test mark of 50');

figure
plot(xa(1,:),ya(1,:));
title('Semester 1 vs Swedish points for fixed test mark of 50');

figure
plot(xa(1,:),ya(2,:));
title('Semester 2 vs Swedish points for fixed test mark of 50');

%% (b)
%fix Swedish points
xb(1,:)=repmat(30,1,91);
%vary school quality
xb(2,:)=linspace(1,10,91);
%vary text marks
xb(3,:)=linspace(1,100,91);

%simulate on net
yb=ugradnet(xb);

figure
plot(xb(2,:),yb(1,:));
title('semester 1 vs school quality for fixed Swedish point score of 30');

figure
plot(xb(2,:),yb(2,:));
title('semester 2 vs school quality for fixed Swedish point score of 30');

figure
plot(xb(3,:),yb(1,:));
title('semester 1 vs test marks for fixed Swedish point score of 30');

figure
plot(xb(3,:),yb(2,:));
title('semester 2 vs test marks for fixed Swedish point score of 30');

%% (c)
xc(1,:)=repmat(25,1,91);
xc(2,:)=repmat(6,1,91);
xc(3,:)=linspace(1,100,91);

%simulate on net
yc=ugradnet(xc);

figure
plot(xc(3,:),yc(1,:));
title('semester 1 vs test marks for fixed Swedish point score of 25 and school quality 6');

figure
plot(xc(3,:),yc(2,:));
title('semester 2 vs test marks for fixed Swedish point score of 25 and school quality 6');