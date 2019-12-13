%% Constraint g3: The inner diameter is a maximum of 25% of the outer diameter

function G3 = g3(x) 

    % Variables
    do = x(2);
    di = x(3);
    
    % Constraint g3
    G3 = di - 0.25*do;
   
end