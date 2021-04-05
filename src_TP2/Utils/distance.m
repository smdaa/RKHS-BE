function d = distance(C, U)
%distance : calculer la distance de C au sous espace representatif U 
%
% Inputs:
%    C - le vecteur représentant l'image du chiffre a déterminer (vecteur)
%    U - les bases orthonormales d'un sous-espaces d'une classe
%
% Outputs:
%    d - distance de C a U
    [m, ~] = size(U);
    d = norm((eye(m) - U * (U')) * C, 2) / norm(C, 2);
end
