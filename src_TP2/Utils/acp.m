function [C, V, D] = acp(X, Precapprox)
%acp : implantation de l'acp classique 
%
% Inputs:
%    X          - tableau des données (chaque colonne est une image)
%    Precapprox - précision souhaité
%
% Outputs:
%    V - les vecteurs propres
%    D - les valeurs propres
%    C - tableau des données dans le le nouveau repère de dimenssion
%    réduite

    %calcul de la matrice de variance/covariance
    [~, n] = size(X);
    Xc = X - mean(X);
    Sigma = (1/n) * (Xc) * Xc';
    
    %calcul des vecteurs/valeurs propres de la matrice Sigma
    [V, D] = eig(Sigma);
    [D, indices_tri] = sort(diag(D),'descend');
    V = V(:,indices_tri);
    
    %calcul de la dimenssion réduite qui permet d'obtenir la précision Precapprox
    k = 1;
    while (sqrt(D(k) / D(1)) > 1 - Precapprox) && (k < length(D))
        k = k + 1;
    end
    V = V(:, 1:k);
        
    C = V' * Xc;
end
