function d = distance(C, U)
    [m, n] = size(U);
    d = zeros(n, 1);
    for i = 1:n
        d(i) = norm((eye(m) - U(:,i) * (U(:,i))') * C) / norm(C);
    end
end

