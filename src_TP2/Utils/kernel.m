function K = kernel(X, choix)
    if strcmp(choix, 'linear')
        K = X' * X;
    elseif strcmp(choix, 'polynomial')
        b = 1;
        d = 2;
        K = (X' * X + b) .^ d;    
    elseif strcmp(choix, 'gauss')
        sigma = 1;
        K = exp(-pdist2(X', X', 'euclidean').^2 ./ (2 * sigma ^ 2));
    end
end