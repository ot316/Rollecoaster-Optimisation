%% Constraint g2: The Mass is greater than zero

function G2 = g2(x) 
    % Parameters 
    p = 3553;
    
    %Variables
    w = x(1);
    do = x(2);
    di = x(3);
    
    % Constraint g2 (mass)
    G2 = 0-(p*pi*w/4 *(do^2-di^2));
end

    