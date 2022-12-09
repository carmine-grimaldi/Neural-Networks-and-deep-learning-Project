function net = forwardPropagation(input, net, errorFunction)
    z = input;
    for layer = 1 : net.getLayersNum()-1
        a = (net.getNetWeight(layer) * z)  + net.getNetBias(layer);
        f = net.getActivationFunction(layer);
        z = f(a);

        net = net.setActivationValue(layer, a);
        net = net.setOutput(layer, z);
    end
    g = getLastLayerFunction(errorFunction);
    net = net.setOutput(layer, g(z));
end

