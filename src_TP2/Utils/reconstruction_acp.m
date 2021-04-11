function x_ = reconstruction_acp(x, u)
    temp = (x - mean(x))' * u;
    x_ = u * temp';  
    % increase contrast
    x_ = 1/(max(x_)- min(x_)) * (x_ - min(x_));
end