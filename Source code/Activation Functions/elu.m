function y = elu(x)
    y = (x>0).*x + (x<=0).*(0.1*(exp(x)-1));
end