function z = reconstruction_kacp_gauss(x, Y, alpha, max_iter)
% Inputs:
%    x          - le vecteur image a reconstruire
%    Y          - Les composantes principales obtenu par kacp
%    max_iter   - le nombre max d'itérations
%
% Outputs:
%    z           - image reconstruit
    N = size(x,1);
    gamma = zeros(size(x));
    for i = 1:N
       gamma(i) = Y' * alpha(i, :)'; 
    end
end