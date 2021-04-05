function [C, U, k] = acp(X, Precapprox)
%acp : implantation de l'acp classique 
%
% Inputs:
%    X          - tableau des données
%    Precapprox - précision souhaité
%
% Outputs:
%    U - les vecteurs propres
%    C - tableau des données dans le le nouveau repère
%    k - k premiers vecteurs de U nécessaire afin d'obtenir une approximation Precapprox

    [~, n] = size(X);
    Xc = X - mean(X);
    Sigma = (1/n) * (Xc) * Xc';
    [U, D] = eig(Sigma);
    [D, indices_tri] = sort(diag(D),'descend');
    U = U(:,indices_tri);
    C = U' * Xc;
    
    k = 1;
    while (sqrt(D(k) / D(1)) > 1 - Precapprox) && (k < length(D))
        k = k + 1;
    end
end
