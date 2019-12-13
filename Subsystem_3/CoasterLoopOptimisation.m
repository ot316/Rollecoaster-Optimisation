tic % tic & toc to find how long the optimisation takes
% Use options to set algorithem to SQP
options = optimoptions('fmincon','Display','iter','Algorithm','sqp'); 
x0 = [1.5,30,0.10]; % Starting values set
A = [];
b = [];
Aeq = [];
beq = [];
lb = [0,15,0]; % Upper and lower bounds of parameters
ub = [5,76,0.2];
nonlcon = [];
%Run Optimiser with CoasterLoop function
[x] = fmincon(@CoasterLoop,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
toc
