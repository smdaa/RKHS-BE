function z = reconstruction_kacp_gauss(x, Y,data, alpha, max_iter)
% Inputs:
%    x          - le vecteur image a reconstruire
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
    z = mean(data,2);
    k = 0;
    while k < max_iter
%        k_z_x = kernel_new_data(z, x, 'gauss');
%        temp = gamma .* k_z_x;
%        z = temp .* x ./ sum(temp);
            pre_z=z;
            xx=bsxfun(@minus,data,z);
            xx=xx.^2;
            xx=-sum(xx)/(2);
            xx=exp(xx);
            xx=xx'.*gamma;

            z=data*xx/sum(xx);
            
            k = k + 1;
    end
    

end