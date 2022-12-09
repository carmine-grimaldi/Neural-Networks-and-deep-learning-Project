function y = lrelu(x)
    alpha = 0.01;
    y = x;
    y(x < 0) = alpha .* x(x < 0);
    %y = (x>=0).*x + (x<0).*(0.2*x);
end