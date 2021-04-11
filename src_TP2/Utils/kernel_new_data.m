function K = kernel_new_data(X,Y, choix)
    if strcmp(choix, 'linear')
        K = X' * Y;
    elseif strcmp(choix, 'polynomial')
        b = 1;
        d = 2;
        K = (X' * Y + b) .^ d;    
    elseif strcmp(choix, 'gauss')
        sigma = 1;
        K = exp(-pdist2(X', Y', 'euclidean').^2 ./ (2 * sigma ^ 2));
    end
end