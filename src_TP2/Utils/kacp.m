function [Y, V, D, alpha] = kacp(K, Precapprox)
%kacp : implantation de l'acp dans le RKHS 
%
% Inputs:
%    X          - tableau des données (chaque colonne est une image)
%    Precapprox - précision souhaité
%    choix      - choix du noyau (linear | polynomial | gauss)
%
% Outputs:
%    V - les vecteurs propres de K
%    D - les valeurs propres de K
%    Y - Les composantes principales
    
    %calcul des vecteurs/valeurs propres de la matrice du noyau K
    [V, D] = eig(K);
    [D, indices_tri] = sort(diag(D), 'descend');
    V = V(:,indices_tri);
    
    %calcul de la dimenssion réduite qui permet d'obtenir la précision Precapprox
    k = 1;
    while (sqrt(D(k) / D(1)) > 1 - Precapprox) && (k < length(D))
        k = k + 1;
    end
    V = V(:, 1:k);
    
    alpha=V(:,1:k);

    for j=1:k
        alpha(:,j)=(alpha(:,j)/norm(alpha(:,j)))/sqrt(D(j));
    end
    
    Y = K * alpha;
end
