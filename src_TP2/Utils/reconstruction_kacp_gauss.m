function z = reconstruction_kacp_gauss(x, Y, alpha, max_iter)
% Inputs:
%    x          - le vecteur image a reconstruire
%    Y          - Les composantes principales obtenu par kacp
%    max_iter   - le nombre max d'itérations
%
% Outputs:
%    z           - image reconstruit
    N = size(alpha, 1);
    gamma = zeros(size(x));
    for i = 1:N
       gamma(i) = sum(Y * alpha(i, :)'); 
    end
    z = ones(size(x));
    k = 0;
    while k < max_iter
       k_z_x = kernel_new_data(z, x, 'gauss');
       temp = gamma .* k_z_x;
       z = temp .* x ./ sum(temp);
       k = k + 1;  
    end
    
    z = k_z_x * x / sum(k_z_x);
end