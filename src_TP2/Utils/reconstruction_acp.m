function z = reconstruction_acp(x, u)
    %z = zeros(size(x, 1), 1);
    z = mean(x, 2);
    for k = 1:size(u, 2)
        xk = x(:, k);
        uk = u(:, k);
       z = z + (xk' * uk) * uk;
    end
    % increase contrast
    %x_ = 1/(max(x_)- min(x_)) * (x_ - min(x_));
end