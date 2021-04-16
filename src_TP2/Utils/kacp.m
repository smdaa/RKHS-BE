function [Y, V, alpha] = kacp(K, Precapprox)
%kacp : implantation de l'acp dans le RKHS 

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
