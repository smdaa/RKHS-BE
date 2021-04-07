function Y = kacp(X, choix)
    N = size(X, 2);
    oneN = repmat(1 / N, N, N);
    K = kernel(X, choix);
    K_ = K - oneN * K - K * oneN + oneN * K * oneN;
    [U, D] = eig(K_);
    [D, indices_tri] = sort(diag(D), 'descend');
    U = U(:,indices_tri);
    alpha = (ones(size(D)) ./ sqrt((D))) .* U;
    Y = alpha' * K;
end
