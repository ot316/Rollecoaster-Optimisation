clear variables
close all
points = 14; %how many data points from each variable to calculate, beware O(n^4) complexity (10 takes 0.13s, 20 takes 22.92s) 

%% latin hypercube Sampling
latin_hypercube = lhsdesign(points,4);

% setting upper and lower bounds for each variable
total_time_min = 2000;
total_time_max = 7000;
total_time_range = total_time_max - total_time_min;
time_of_top_curve_min = 1000;
time_of_top_curve_max = 2000;
time_of_top_curve_range = time_of_top_curve_max - time_of_top_curve_min;
theta_min = 70;
theta_max = 90;
theta_range = theta_max - theta_min;
radius_min = 20;
radius_max = 40;
radius_range = radius_max - radius_min;

lhs_total_time = total_time_min +((latin_hypercube(:,1))*total_time_range);
lhs_time_of_top_curve = time_of_top_curve_min +((latin_hypercube(:,1))*time_of_top_curve_range);
lhs_theta = theta_min +((latin_hypercube(:,1))*theta_range);
lhs_radius = radius_min +((latin_hypercube(:,1))*radius_range);

figure(1)

scatter(latin_hypercube(:,1), latin_hypercube(:,3), 'filled')
title('Latin Hypercube Values for Total Time against Theta')
xlabel('Latin Hypercube Total Time')
ylabel('Latin Hypercube Theta') 

%% Building Database with Sampled data

%Static Variables
air_density = 1.1;
frontal_area = 7;
drag_coefficient = 1.225;
g = 9.81;
mass = 500;
friction_coefficient = 0.01;

data_base = zeros((points*4),8); %initialise empty database

%database header:  "Maximmum Velocity", "Drop Distance", "Maximum Slope Velocity", "G Force", "Total Time", "Time of Curve", "Incline Angle", "Radius of Exit Curve"};

count = 1; %index counter for adding arrays to database

for i = 1:points
    for ii = 1:points
        for iii = 1:points
           for iiii = 1:points
              %call eulers method function that calculates remaining variables from the giveninputs
              [max_velocity, drop_distance, start_slope_velocity, g_force] = GenerateData(lhs_total_time(i), lhs_time_of_top_curve(ii), lhs_theta(iii), lhs_radius(iiii), air_density, frontal_area, drag_coefficient, g, mass, friction_coefficient, false);
              %append new value to database
              data_base(count,:) = [max_velocity, drop_distance, start_slope_velocity, g_force, lhs_total_time(i), lhs_time_of_top_curve(ii), lhs_theta(iii), lhs_radius(iiii)];
              count= count+1;
              points^4;
            end
        end
    end
end

disp('Database generated');

csvwrite('data_base.csv',data_base);
disp('Database saved as data_base.csv');

%% Plot single data base entry
figure(2)
%call GenerateData function with plot flag set to true for arbitrary values.
plot = GenerateData(30, 8, 12, 35, air_density, frontal_area, drag_coefficient, g, mass, friction_coefficient, true);


%% Plotting Simulation Data
figure(3)
plot_drop_distance = data_base(:,1);
plot_max_vel = data_base(:,2);
plot_total_time = data_base(:,5);

scatter3(plot_drop_distance, plot_max_vel, plot_total_time, 'filled')
title('Scatter plot of parameters')
xlabel('Drop Distance m')
ylabel('Max Velocity m/s')
zlabel('Total Time s')

%% Preparing Data
% scaling by min-max normalisation. Implemented manually for easy
% unscaling.
minimumN = zeros(8,1);
rangeN = zeros(8,1);
data_base_norm = zeros(length(data_base), 8);

for i=1:8
    minimumN(i,1) = min(data_base(:,i));
    rangeN(i,1) = max(data_base(:,i)) - min(data_base(:,i));
    data_base_norm(:,i) = rescale(data_base(:,i), 0, 1);
end


% MATLAB random seed 46
rng(46);             
% New random index order for data sets
newInd = randperm(length(data_base_norm)); 
data_base_norm_shuffled = data_base_norm(newInd,:); %shuffled

%separate labels and features
data_base_X = data_base_norm_shuffled(:,2:end);  %features
data_base_y = data_base_norm_shuffled(:,1);      %labels


%% Linear Regression

splitPt = floor(0.75*length(data_base_y));

% split data
database_X_train = data_base_X(1:splitPt,:);
database_y_train = data_base_y(1:splitPt,:);

database_X_test = data_base_X(splitPt:end,:);
database_y_test = data_base_y(splitPt:end,:);


beta = mvregress(database_X_train, database_y_train)
mdl = fitlm(database_X_train,database_y_train); % not robust
mdlr = fitlm(database_X_train,database_y_train,'RobustOpts','on'); %robust

figure(5)
plotResiduals(mdl)

figure(6)
subplot(1,2,1)
plotResiduals(mdl,'probability')
subplot(1,2,2)
plotResiduals(mdlr,'probability')

% R squared Value
Rsq_data_base = 1 - norm(database_X_test*beta - database_y_test)^2/norm(database_y_test-mean(database_y_test))^2


%% Optimisation

ub = [
max(data_base_norm_shuffled(:,2)),
max(data_base_norm_shuffled(:,3)),
(6-minimumN(4))/rangeN(4),
max(data_base_norm_shuffled(:,5)),
max(data_base_norm_shuffled(:,6)),
max(data_base_norm_shuffled(:,7)),
max(data_base_norm_shuffled(:,8)),
];

lb = [
(0.076-minimumN(2))/rangeN(2),
min(data_base_norm_shuffled(:,3)),
min(data_base_norm_shuffled(:,4)),
min(data_base_norm_shuffled(:,5)),
min(data_base_norm_shuffled(:,6)),
min(data_base_norm_shuffled(:,7)),
min(data_base_norm_shuffled(:,8)),
];

fun = @(x) -(beta(1,1)*x(1) + beta(2,1)*x(2) + beta(3,1)*x(3) + beta(4,1)*x(4) + beta(5,1)*x(5) + beta(6,1)*x(6) + beta(7,1)*x(7));

x0 = [lb];
A = [0,0,0,-1,1,0,0];
b = 0; 
Aeq = [];
beq = [];
LB = lb;
UB = ub;
nonlcon = [];
fminoptions = optimoptions('fmincon','Algorithm','sqp');
gaoptions = optimoptions('ga','PlotFcn', @gaplotbestf);
tic
[xfmin, MaximumVelocityscaledfmin] = fmincon(fun, x0, A, b, Aeq, beq, LB, UB, nonlcon, fminoptions);
toc
tic
%[xga, MaximumVelocityscaledga] = ga(fun,7,A,b,Aeq,beq,LB,UB,[],gaoptions);
toc
%remove normalisation

for i =1:7
    xfmin(i) = (xfmin(i) * rangeN(i + 1)) + minimumN(i + 1);
    %xga(i) = (xga(i) * rangeN(i + 1)) + minimumN(i + 1);
end

xfmin(1) = xfmin(1)*1000;
%xga(1) = xga(1)*1000;
%fmincon sqp
xfmin
MaximumVelocityfmin = -(MaximumVelocityscaledfmin*rangeN(1)) - minimumN(1)

%Genetic Algorithm
%xga
%MaximumVelocityga = -(MaximumVelocityscaledga*rangeN(1)) - minimumN(1)

figure(7)
subplot(2,1,1);
fun1 = @(x1, x2) ((beta(5,1)*x1) + (beta(6,1)*x2));

fsurf(fun1)
hold on
title('Regression equation of Maximum Velocity 1')
xlabel('Normalised Total Time Over Drop')
ylabel('Normalised Radius')
zlabel('Normalised Maximum Velocity')
hold off


fun2 = @(x1, x2) ((beta(5,1)*x1) + (beta(4,1)*x2));
subplot(2,1,2);
fsurf(fun2)
hold on
title('Regression equation of Maximum Velocity 2')
xlabel('Normalised Total Time Over Drop')
ylabel('Normalised Angle of Incline')
zlabel('Normalised Maximum Velocity')
hold off

%% Generate Data Function
function [max_velocity, drop_distance, start_slope_velocity, g_force] = GenerateData(total_time, time_of_top_curve, theta, radius, rho, A, CD, g, mass, mu, flag)
V0=0; % initial speed
S0=0;
k=0.5*CD*rho*A; % Coefficient
S=zeros(1,ceil(total_time)); %
V=zeros(1,ceil(total_time)); %
curvetheta = zeros(1,ceil(time_of_top_curve));
S(1)=S0;
V(1)=V0;

dt=0.0001;
%changing incline as coaster clears the peak
for i=1:ceil(time_of_top_curve)
    curvetheta(i) =  (theta - ((time_of_top_curve - i) * theta/time_of_top_curve));
    V(i+1) = V(i) + dt * ((g*sind(curvetheta(i)))  - ((k/mass) * V(i)^2) - (mu * g * cosd(curvetheta(i))));
    S(i) = V(i)*dt;
end

%constant incline as coaster descends down slope
for i=ceil(time_of_top_curve):ceil(total_time)
    V(i+1) = V(i) + dt * ((g*sind(theta))  - ((k/mass) * V(i)^2) - (mu * g * cosd(theta)));
    S(i) = V(i)*dt;
end

%split data for plotting

VelocityProfileCurve = V;
VelocityProfileCurve(ceil(time_of_top_curve)+1:ceil(total_time)+1) = NaN;

VelocityProfileDrop = V;
VelocityProfileDrop(1:ceil(time_of_top_curve)-1) = NaN; 


t=(0:total_time)*dt;
% vterminal=sqrt(g*mass/k); % Terminal velocity
drop_distance = sum(S,'all');
max_velocity = V(ceil(total_time));
start_slope_velocity = V(ceil(time_of_top_curve));


Acceleration = (max_velocity^2)/radius;

g_force = Acceleration/g;

if flag == true
    plot(t,VelocityProfileCurve, 'r');
    hold on
    plot(t,VelocityProfileDrop, 'b');
    title('Velocity Profile With Air Resistance and Bearing Friction');
    xlabel('time in sec');
    ylabel('velocity in m/s');
    legend ('Curve Velocity','Drop Velocity', 'Location', 'southeast');
end
end






