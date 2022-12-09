function delta = backPropagation(net, labels, errorFunction)
    layersNum = net.getLayersNum();
    delta = cell(1, layersNum-1);
    
    % Calcolo i delta dell'ultimo strato
    derivFun = getDerivatives(net.getActivationFunction(layersNum-1));
    a = net.getActivationValue(layersNum-1);
    delta{layersNum-1} = derivFun(a);
    
    derivFun = getDerivatives(errorFunction);
    output = net.getOutput(net.getLayersNum()-1);
    delta{layersNum-1} = delta{layersNum-1} .* derivFun(output, labels);

    % Calcoli i delta degli strati interni
    for layer = layersNum-2 : -1 : 1
        w = net.getNetWeight(layer+1);
        delta{layer} = w' * delta{layer+1};

        derivFun = getDerivatives(net.getActivationFunction(layer));
        a = net.getActivationValue(layer);
        delta{layer} = delta{layer} .* derivFun(a);
    end
end