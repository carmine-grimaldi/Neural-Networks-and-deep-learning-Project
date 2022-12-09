function [deltaW, deltaB] = initDelta(net, variation)
    layersNum = net.getLayersNum();

    % Inizializzazione degli array di celle
    deltaW = cell(1, layersNum-1);
    deltaB = cell(1, layersNum-1);

    % Per ogni strato si crea una matrice con tutti valori uguali a "variation"
    for layer = 1 : layersNum-1
        deltaW{layer} = variation * ones(size(net.getNetWeight(layer)));
        deltaB{layer} = variation * ones(size(net.getNetBias(layer)));
    end
end