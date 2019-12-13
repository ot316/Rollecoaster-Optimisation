tic
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
x0 = [1.5,30,0.10];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [0,15,0];
ub = [5,76,0.2];
nonlcon = [];
[x] = fmincon(@CoasterLoop,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
toc
% C - 0 - 5
% Height - 0 - (Ollie)76m
% Max curvature - 0 - 0.2 

%x = [4.9,34.5]
%CoasterFunctionX(x)
% Unsafe isn't working - DONE
% Current Workflow
% Report
% Optimises - DONE
% - Safe G force plot to match  - DONE
% - Math verification - Match G to Time - DONE
% - Multi-Variable Curve
% - Intergrate the Lenght value - DONE
% - Boundry Conditions: 
%   - Max Curvature
%   - Energy Losses

% In: C, C adjustment values, Height, 
% Out: Minmised space up to the G Forec Safe plot
% Constraints:
% - Safety plot, Max height
% Constrained Gradient-based Optimisation