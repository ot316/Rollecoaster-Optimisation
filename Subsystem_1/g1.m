%% Constraint g1: The mass is less than 2kg

function G1 = g1(x)
    % Parameters 
    p = 3553;
    
    % Variables
    w = x(1);
    do = x(2);
    di = x(3);
    
    % Constraint g1
    G1 = p*pi*w/4 *(do^2-di^2) - 2;
    
end
    