% Funzione cross entropy che consente di distinguere il caso in cui si
% voglia utilizzare softMax come funzione di attivazione sull'ultimo layer
function y = crossEntropySoftMax(output, target)
    y = crossEntropy(output, target);
end