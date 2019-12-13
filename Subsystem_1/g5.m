%% Constraint g3: The width is a maximum of 60% of the outer diameter

function G5 = g5(x) 

    % Variables
    w = x(1);
    do = x(2);
    
    % Constraint gg
    G5 = w - 0.6*do;
   
end