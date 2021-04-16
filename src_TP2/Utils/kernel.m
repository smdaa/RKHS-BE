function K = kernel(X, choix, args)
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