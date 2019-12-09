function [max_velocity, drop_distance, start_slope_velocity, g_force] = GenerateData(total_time, time_of_top_curve, theta, radius, rho, A, CD, g, mass, mu, flag)
V0=0; % initial speed
S0=0;
k=0.5*CD*rho*A; % Coefficient
S=zeros(1,ceil(total_time)); % 
V=zeros(1,ceil(total_time)); % 
curvetheta = zeros(1,ceil(time_of_top_curve));
S(1)=S0;
V(1)=V0;

dt=0.1;
%changing incline as coaster clears the peak
for i=1:ceil(time_of_top_curve)
    curvetheta(i) = theta - ((time_of_top_curve - i) * theta/time_of_top_curve);
    V(i+1) = V(i) + dt * (g * cosd(curvetheta(i)) - ((k/mass) * V(i)^2) - (mu * g * sind(curvetheta(i))));
    S(i) = V(i)*dt;
end

%constant incline as coaster descends down slope
for i=ceil(time_of_top_curve):ceil(total_time)
    V(i+1) = V(i) + dt * (g * cosd(theta) - ((k/mass) * V(i)^2) - (mu * g * sind(theta)));
    S(i) = V(i)*dt;
end



VelocityProfileCurve = V;
VelocityProfileCurve(ceil(time_of_top_curve)+1:ceil(total_time)+1) = NaN;

VelocityProfileDrop = V;
VelocityProfileDrop(1:ceil(time_of_top_curve)-1) = NaN;

t=(0:total_time)*dt;
% vterminal=sqrt(g*mass/k); % Terminal velocity
drop_distance = sum(S);
max_velocity = V(ceil(total_time));
start_slope_velocity = V(ceil(time_of_top_curve));


Acceleration = max_velocity^2/radius;

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