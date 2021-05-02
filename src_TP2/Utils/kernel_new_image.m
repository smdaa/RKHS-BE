function K = kernel_new_image(X,Y, choix, args)
if strcmp(choix, 'linear')
    K = X' * Y;
elseif strcmp(choix, 'polynomial')
    b = 1;
    d = args;
    K = (X' * Y + b) .^ d;
elseif strcmp(choix, 'gauss')
    sigma = args;
    K = exp(-pdist2(X', Y', 'euclidean').^2 ./ (2 * sigma ^ 2));
end
end