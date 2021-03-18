function d = distance(C, U)
%distance : calculer la distance de C au sous espace representatif U 
%
% Inputs:
%    C - tableau des données dans le le nouveau repère
%    U - les vecteurs propres
%
% Outputs:
%    d - distance de C a U
    [m, ~] = size(U);
    d = norm((eye(m) - U * (U')) * C) / norm(C);
end

