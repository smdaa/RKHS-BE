function [V, alpha] = kacp(K, Precapprox)
%kacp : implantation de l'acp dans le RKHS
%
% Inputs:
%    K          - la matrice noyau
%    Precapprox - précision souhaité
%
% Outputs:
%    V         - les vecteurs propres de la matrice noyau
%    alpha     - pour calculer les composantes principales
%    dim_red   - imposer la dimension réduite sans faire le calcul qui permet d'obtenir la précision Precapprox

%calcul des vecteurs/valeurs propres de la matrice du noyau K
[V, D] = eig(K);
[D, indices_tri] = sort(diag(D), 'descend');
V = V(:,indices_tri);

% normalisation des vecteurs propres
V = V ./ repmat(norm(V), size(V,1),1);


%calcul de la dimenssion réduite qui permet d'obtenir la précision Precapprox
k = 1;
while (sqrt(D(k) / D(1)) > 1 - Precapprox) && (k < length(D))
    k = k + 1;
end


V = V(:, 1:k);
alpha=(ones(k, 1) ./ sqrt(D(1:k)))' .* V;

end
