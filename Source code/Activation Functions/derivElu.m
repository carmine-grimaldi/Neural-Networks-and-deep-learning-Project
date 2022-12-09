function y=derivElu(x)
    y = (x>0).*1 +  (x<=0).*(elu(x)+0.1);
end