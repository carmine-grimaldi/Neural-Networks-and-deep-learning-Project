function y=derivLRelu(x)
    alpha = 0.01;
    y = x;
    y(x ~= 0) = x(x ~= 0) ./ x(x ~= 0);
    y(x < 0) = alpha;
end