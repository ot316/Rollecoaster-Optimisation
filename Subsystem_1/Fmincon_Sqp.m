
%% Optimisation Using Fmincon Sqp.
% Remove any existing values
clear;

% Start timer 
tic 

disp('1. Optimising the wheel geometry');

% Parameter input 
g = 9.81;           % Acceleration due to gravity
Wp = 100*g;         % Load per wheel from the mass of the passengers
Wc = 267.5*g;       % Load per wheel from the mass of the cart
poi1 = 0.4074;      % Average Poisson Ratio of material options
poi2 = 0.295;       % Poisson Ratio of steel (tracks)
E1 = 2.853.*10^6;   % Average Young's Modulus of material options
E2 = 2*10^8;        % Young's Modulus of steel (tracks)
p = 1221;           % Average density of material options

% Initial guess
x0 = [0.05,0.13,0.03];

% Variable bounds (w, do, di)
lb = [0.01 0.1 0.03];
ub = [0.3 0.3775 0.3];

% Linear constraints (of which there are none)
A = [];
b = [];
Aeq = [];
beq = [];

% Nonlinear constraints (Calls a function below)
nonlc = @nlc;

% Objective function
FUNC = @(x) ((((3./(2.*pi.*x(1))).*(Wc+Wp) + ((3.*p.*g./8).*(x(2).^2-x(3).^2))).*((1-poi1.^2)/E1 + (1-poi2.^2)/E2))./x(2)).^0.5.*(Wc + Wp + (pi.*p.*x(1).*g./4).*(x(2).^2-x(3).^2));

% Running the Optimisation Function with fmincon sqp
options = optimoptions('fmincon', 'Display', 'iter' , 'Algorithm','sqp');
x = fmincon(FUNC,x0,A,b,Aeq,beq,lb,ub,nonlc, options);



% Display solution
disp('Solution')
disp(['w = ' num2str(x(1))])
disp(['do = ' num2str(x(2))])
disp(['di = ' num2str(x(3))])
d = FUNC3(x(1),x(2),x(3),poi1,E1,p);
toc

disp(' ')
disp(['The provisional Rolling Resistance following optimisation of the wheel geometry is ' num2str(d) ' N']);

%% Optimising the Material of the wheels

w = (x(1));
do = (x(2));
di = (x(3));



% PLA
poi3 = 0.4;
E3 = 3.58*10^6;
p3 = 1.27*10^3;
pla1 = FUNC3(w,do,di,poi3,E3,p3);
pla = num2str(pla1);
%disp(['Rolling Resistance for PLA = ' pla ' N'])
k(1,1) = pla1;
l(1,1) = ("PLA");


% tpPUR
poi4 = 0.42;
E4 = 2.07* 10^6;
p4 = 1.24*10^3;
tppur1 = FUNC3(w,do,di,poi4,E4,p4);
tppur = num2str(tppur1);
disp(['Rolling Resistance for tpPUR = ' tppur ' N'])
k(1,2) = tppur1;
l(1,2) = "tpPUR";

% PS
poi5 = 0.4;
E5 = 3.28* 10^6;
p5 = 1.04*10^3;
ps1 = FUNC3(w,do,di,poi5,E5,p5);
ps = num2str(ps1);
%disp(['Rolling Resistance for PS = ' ps ' N'])
k(1,3) = ps1;
l(1,3) = "PS";

% POM
poi6 = 0.407;
E6 = 3.2* 10^6;
p6 = 1.43*10^3;
pom1 = FUNC3(w,do,di,poi6,E6,p6);
pom = num2str(pom1);
%disp(['Rolling Resistance for POM = ' pom ' N'])
k(1,4) = pom1;
l(1,4) = "POM";

% PMMA
poi7 = 0.4;
E7 = 3.23* 10^6;
p7 = 1.2*10^3;
pmma1 = FUNC3(w,do,di,poi7,E7,p7);
pmma = num2str(pmma1);
%disp(['Rolling Resistance for Kevlar = ' pmma ' N'])
k(1,5) = pmma1;
l(1,5) = "PMMA";

% PET
poi8 = 0.4;
E8 = 3.01* 10^6;
p8 = 1.39*10^3;
pet1 = FUNC3(w,do,di,poi8,E8,p8);
pet = num2str(pet1);
%disp(['Rolling Resistance for PET = ' pet ' N'])
k(1,6) = pet1;
l(1,6) = "PET";

% PC
poi9 = 0.41;
E9 = 2.52* 10^6;
p9 = 1.21*10^3;
pc1 = FUNC3(w,do,di,poi9,E9,p9);
pc = num2str(pc1);
%disp(['Rolling Resistance for PC = ' pc ' N'])
k(1,7) = pc1;
l(1,7) = "PC";

% PA
poi11 = 0.42;
E11 = 2.04* 10^6;
p11 = 1.15*10^3;
pa1 = FUNC3(w,do,di,poi11,E11,p11);
pa = num2str(pa1);
%disp(['Rolling Resistance for PA = ' pa ' N'])
k(1,8) = pa1;
l(1,8) = "PA";

% ABS
poi12 = 0.41;
E12 = 2.75* 10^6;
p12 = 1.06*10^3;
abss1 = FUNC3(w,do,di,poi12,E12,p12);
abss = num2str(abss1);
%disp(['Rolling Resistance for ABS = ' abss ' N']);
k(1,9) = abss1;
l(1,9) = "ABS";

%disp(k);
names = {'PLA'; 'tpPUR'; 'PS'; 'POM'; 'PMMA'; 'PET'; 'PET'; 'PC'; 'PA'; 'ABS'};
plot(k,'b.','MarkerSize',20);
title('Rolling Resistance for each material option', 'fontsize', 14);
xlabel('Material');
ylabel('Rolling Resistance (N)');
set(gca,'xtick',[1:9],'xticklabel',names);
%plot(k,'x')
t = min(k);
val = min(k(~ismember(k,0)));
ind = find(val==k);
n = l(1,ind);

disp(' ');
disp(' ');
disp('2. Optimising Material Choice:');

disp('The material with the lowest rolling resistance is: ' );
fprintf(l(1,ind));
disp(' ')
disp(' ')
disp(['Final Solution for Minimising Rolling Resistance = ' num2str(t) ' N'])


% Parameters to carry into other subsystems
disp(' ')
% Number of people per ride
Np = 24;
% Mass per cart, including the mass of the passengers and wheels
mc = 4/g*(Wp+Wc) + (p3*pi*w*(do^2-di^2));
% Mass of the whole train, consisting of 6 carts. Includes people, the cart
% and the wheels
mac = 6*mc; 
% Load from the whole train (6 carts)
W = mac*g;

% Load from the wheels
Ww = g*pi*(do^2-di^2)*p3;
% Constant of elastic properties
D = 3/4*((1-poi3^2)/E3 - (1 - poi2^2)/E2);
% Load on the tracks per cart
Ws = Wp + Ww + Wc;
% Wheel sinkage
z = 2*Ws*D/(pi*w);
% Coefficient of rolling resistance
crr = sqrt(z/do);

disp(['The number of people per cart is ', num2str(Np)]);
disp(['The mass of the rollercoaster train is ', num2str(mac) 'kg']);
disp(['The coefficient of rolling resistance is ', num2str(crr)]);

%% Functions

function [c,ceq] = nlc(x)
    c = [g1(x); g2(x); g3(x); g4(x); g5(x)];
    ceq = 0;
end 


function [rr] = FUNC3(w10,do10,di10,poi10,E10,p10)
    g = 9.81;
    Wp = 100*g;     % Mass of a person (Load on one wheel set)
    Wc = 267.5*g;   % Mass of the cart per person (Load from the cart per wheel)
    poi2 = 0.295;   % Poisson Ratio of steel 
    E2 = 2*10^8;    % Young's Modulus of steel (tracks) 
    rr = (((((3./(2.*pi.*w10)).*(Wc+Wp) + ((3.*p10.*g./8).*(do10.^2-di10.^2))).*((1-poi10.^2)./E10 + (1-poi2.^2)/E2))./do10).^0.5).*(Wc + Wp + (pi.*p10.*w10.*g./4).*(do10.^2-di10.^2));
end












