function K = kernel(X, choix, args)
%kernel : calcul de la matrice noyau d'une base de donnée X : (chaque colonne est une image)
%
% Inputs:
%    X          - tableau des données (chaque colonne est une image)
%    choix      - choix du noyau : (linear | polynomial | euclidean)
%    args       - parametre de calcul (d pour le noyau polynomial | sigma pour le noyau euclidean)
%
% Outputs:
%    K - la matrice noyau

if strcmp(choix, 'linear')
    K = X' * X;
elseif strcmp(choix, 'polynomial')
    b = 1;
    d = args;
    K = (X' * X + b) .^ d;
elseif strcmp(choix, 'gauss')
    sigma = args;
    K = exp(-pdist2(X', X', 'euclidean').^2 ./ (2 * sigma ^ 2));
end
end