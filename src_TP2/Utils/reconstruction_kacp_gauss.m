function z = reconstruction_kacp_gauss(x, Y, alpha, max_iter)
% Inputs:
%    x          - le vecteur image a reconstruire
%    Y          - Les composantes principales obtenu par kacp
%    max_iter   - le nombre max d'itérations
%
% Outputs:
%    z           - image reconstruit
    gamma = alpha * Y;
    
    k = 0;
    z = x;
    while(k < max_iter)
       sigma = 1;
       k_z_xi = exp(-pdist2(x', z', 'euclidean').^2 ./ (2 * sigma ^ 2));       
       temp = gamma' *k_z_xi;
       z = (temp * x) ./ (sum(temp));
       k = k + 1;
    end
end