function y=derivIdentity(x)
    y = x;
    y(x ~= 0) = x(x ~= 0) ./ x(x ~= 0);
end