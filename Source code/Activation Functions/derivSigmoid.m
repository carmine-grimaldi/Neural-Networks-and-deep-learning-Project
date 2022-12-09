function y=derivSigmoid(x)
    z=sigmoid(x);
    y=z .* (1-z);
end