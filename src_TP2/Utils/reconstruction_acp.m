function z = reconstruction_acp(x, data, u)
z = mean(data, 2) + u * (u') * x;
end