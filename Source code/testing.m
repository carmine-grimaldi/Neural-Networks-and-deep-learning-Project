function accuracy = testing(net, testSet, funzErr)
    net = forwardPropagation(testSet.images, net, funzErr);
    
    % Recupero il vettore delle predizioni
    [~, k] = max(net.getOutput(net.getLayersNum()-1));

    % Predizioni corrette / numero di casi possibili
    accuracy = sum(k == testSet.labels)/size(testSet.images, 2);
end