function d = distance(C, U)
%distance : calculer la distance de C au sous espace representatif U 
%
% Inputs:
%    C - le vecteur representant l'image du chiffre a déterminer
%    U - les bases orthonormales de chacun des sous-espaces
%
% Outputs:
%    d - distance de C a U
    [m, ~] = size(U);
    d = norm((eye(m) - U * (U')) * C, 2) / norm(C, 2);
end

