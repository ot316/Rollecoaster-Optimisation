%% Constraint g4: The inner diameter is at least 10% of the outer diameter

function G4 = g4(x) 

    % Variables
    do = x(2);
    di = x(3);
    
    % Constraint g4
    G4 = 0.1*do-di;
   
end