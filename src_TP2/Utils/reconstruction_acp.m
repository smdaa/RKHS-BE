function x_ = reconstruction_acp(x, u)
%     x_ = ones(size(x));
%     for k = 1:size(u, 2)
%         x_ = x_ + (x' * u(:, k)) * u(:, k); 
%     end
    temp = x' * u;
%     x_ = ones(size(x)) + u * temp'
      x_ = abs(u * temp')
end
