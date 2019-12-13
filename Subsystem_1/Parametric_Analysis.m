%% Parametric Analysis

% Clear the Command Window
clc

% Known values 
g = 9.81;       % Acceleration due to gravity
Wp = 100*g;     % Load per wheel from passengers
Wc = 267.5*g;   % Load per wheel from the mass of the cart
poi2 = 0.295;   % Poisson Ratio of steel 
E2 = 2*10^8;    % Young's Modulus of steel (tracks)


% Variables set to the average of existing values
w = 0.08;
do = 0.08;
di = 0.02;

% Upper and lower bounds for Elastic (Young's Modulus), Poisson's Ratio and
% Density

E_upper = 5*10^6;
E_lower = 2*10^6;

poi_lower = 0.35;
poi_upper = 0.45;

p_lower = 1*10^3;
p_upper = 2*10^3;

%Average material property values
p = 1.221*10^3;
E = 2.8533*10^6;
poi = 0.4074;

%% Plotting Young's Modulus, Poisson's Ratio, and Density against the Objective Function

figure;
subplot(2,2,1)
p_values = linspace(p_lower, p_upper, 10);
F1 = (((((3./(2.*pi.*w)).*(Wc+Wp) + ((3.*p_values.*g./8).*(do.^2-di.^2))).*((1-poi1.^2)./E + (1-poi2.^2)./E2))./do).^0.5).*(Wc + Wp + (pi.*p_values.*w.*g./4).*(do.^2-di.^2));
plot(p_values,F1)
title('Effect of Density on the Rolling Resistance of a Wheel')
xlabel('Density (p)')
ylabel('Rolling Resistance (N)')
set(gca,'Color','w')

subplot(2,2,2)
E_values = linspace(E_lower, E_upper, 10);
F2 = (((((3./(2.*pi.*w)).*(Wc+Wp) + ((3.*p.*g./8).*(do.^2-di.^2))).*((1-poi1.^2)./E_values + (1-poi2.^2)./E2))./do).^0.5).*(Wc + Wp + (pi.*p.*w.*g./4).*(do.^2-di.^2));
plot(E_values,F2)
title('Effect of Youngs Modulus on the Rolling Resistance of a Wheel')
xlabel('Elastic Modulus (E)')
ylabel('Rolling Resistance (N)')
set(gca,'Color','w')

subplot(2,2,3)
poi_values = linspace(poi_lower, poi_upper, 10);
F3 = (((((3./(2.*pi.*w)).*(Wc+Wp) + ((3.*p.*g./8).*(do.^2-di.^2))).*((1-poi_values.^2)/E1 + (1-poi2.^2)/E2))./do).^0.5).*(Wc + Wp + (pi.*p.*w.*g./4).*(do.^2-di.^2));
plot(poi_values,F3)
title('Effect of Poissons Ratio on the Rolling Resistance of a Wheel')
xlabel('Poisson Ratio (sigma)')
ylabel('Rolling Resistance (N)')
set(gca,'Color','w')

%% Creating a surface from do, di and w against the objective function

% Setting Constants
g = 9.81;
Wc = 267.5.*g;
Wp = 100.*g;
p = 3553;
poi1 = 0.3575;
poi2 = 0.295;
E10 = 7.23 .* 10^7;
E2 = 2.*10^8;

% Upper and lower bounds for dimensions
w_upper = 10;
w_lower = 40;

do_lower = 50;
do_upper = 100;

di_lower = 0;
di_upper = 50;

% Average value for each dimension taken from what is available to buy
wa = 10;
doa = 50;
dia = 10;


% Creating the meshgrid function for do vs di vs f
[do_values,di_values] = meshgrid(50:.100:100, 0:.100:50); % Switch the two variables depending on those to compare
FUNC1 = ((((3./(2.*pi.*wa)).*(Wc+Wp) + ((3.*p.*g./g).*(do_values.^2-di_values.^2))).*((1-poi1.^2)/E10 + (1-poi2.^2)/E2))./do_values).^0.5.*(Wc + Wp + (pi.*p.*wa.*g./4).*(do_values.^2-di_values.^2));
figure;
subplot(2,2,1);
surf(do_values,di_values,FUNC1);
title('The effect of wheel geometry on the objective function')
xlabel('Outer diameter of the wheel (do)') 
ylabel('Inner diameter of the wheel (di)')
zlabel('Objective function')

% Creating the meshgrid function
[w_values,di_values] = meshgrid(10:.100:60, 0:.100:50); % Switch the two variables depending on those to compare
FUNC2 = ((((3./(2.*pi.*w_values)).*(Wc+Wp) + ((3.*p.*g./g).*(doa.^2-di_values.^2))).*((1-poi1.^2)/E10 + (1-poi2.^2)/E2))./doa).^0.5.*(Wc + Wp + (pi.*p.*w_values.*g./4).*(doa.^2-di_values.^2));
subplot(2,2,2);
surf(di_values,w_values,FUNC2);
title('The effect of wheel geometry on the objective function')
xlabel('Inner diameter of the wheel (di)') 
ylabel('Width of the wheel (w)')
zlabel('Objective function')

% Creating the meshgrid function
[w_values,do_values] = meshgrid(10:.100:60, 40:.100:90); % Switch the two variables depending on those to compare
FUNC3 = ((((3./(2.*pi.*w_values)).*(Wc+Wp) + ((3.*p.*g./g).*(do_values.^2-dia.^2))).*((1-poi1.^2)/E10 + (1-poi2.^2)/E2))./do_values).^0.5.*(Wc + Wp + (pi.*p.*w_values.*g./4).*(do_values.^2-dia.^2));
subplot(2,2,3);
surf(do_values,w_values,FUNC3);
title('The effect of wheel geometry on the objective function')
xlabel('Outer diameter of the wheel (do)') 
ylabel('Width of the wheel (w)')
zlabel('Objective function')

