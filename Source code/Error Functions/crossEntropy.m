% Funzione della cross entropy multi-classe
function y = crossEntropy(output, target)
    y = sum(-sum(target .* log(max(output, 0.09)), 2));
end