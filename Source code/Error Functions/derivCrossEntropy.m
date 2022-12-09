function e = derivCrossEntropy(Y,T)
    e = -sum( T ./ Y , 1);
end