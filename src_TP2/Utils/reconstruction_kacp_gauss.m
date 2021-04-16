function z = reconstruction_kacp_gauss(Y, data, alpha, args, max_iter)
% Inputs:
%    data       - le tableau des donnees
%    Y          - Les composantes principales obtenu par kacp
%    max_iter   - le nombre max d'itérations
%
% Outputs:
%    z           - image reconstruit

    N = size(alpha, 1);
    gamma = zeros(N,1);
    for i = 1:N
       gamma(i) = sum(Y * alpha(i, :)'); 
    end
    z = mean(data, 2);
    k = 0;
    while k < max_iter
            temp = kernel_new_data(data, z, 'gauss', args) .* gamma;
            z=data * temp/sum(temp); 
            k = k + 1;
    end
    
end