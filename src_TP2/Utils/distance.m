function d = distance(C, U)
    [m, n] = size(U);
    d = norm((eye(m) - U * (U')) * C) / norm(C);
    
end

