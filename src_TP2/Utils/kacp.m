function Y = kacp(X, choix)
    K = kernel(X, choix);
    [U2, D2] = eig(K);
    [D2, indices_tri] = sort(diag(D2), 'descend');
    U2 = U2(:,indices_tri);
    alpha = (ones(size(D2)) ./ sqrt((D2))) .* U2;
    Y = alpha' * K;
end
