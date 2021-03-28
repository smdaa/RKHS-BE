function K = kernel(X, choix)
    if strcmp(choix, 'linear')
        K = X' * X;
    elseif strcmp(choix, 'polynomial')
        b = 1;
        d = 2;
        K = (X' * X + b) .^ d;
    end
end