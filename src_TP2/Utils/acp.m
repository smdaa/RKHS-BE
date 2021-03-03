function [C U k] = acp(X, precapprox)
    [m n] = (size(X));
    Xc = X - mean(X);
    sigma = (1/n)*(Xc)*Xc';
    sizesig = size(sigma);
    [U,val] = eig(sigma);
    [~,indices_tri] = sort(diag(val),'descend');
    U = U(:,indices_tri);
    C = U' * Xc;
    k = 1;
    while (sqrt(val(k)/val(1)) > 1 - precapprox) & (k < length(val))
        k = k + 1;
    end
end