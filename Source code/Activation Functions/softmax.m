function s = softmax(x)
    max_x = max(x,[],1);
    s = exp(x-max_x) ./ sum(exp(x-max_x), 1);
end