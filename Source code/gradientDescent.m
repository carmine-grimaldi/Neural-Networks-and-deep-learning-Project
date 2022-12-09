function net = gradientDescent(net, derW, derB, eta)
    for layer = 1: net.getLayersNum()-1
        net = net.setNetWeight(layer, net.getNetWeight(layer) - (eta * derW{layer}));
        net = net.setNetBias(layer, net.getNetBias(layer) - (eta * derB{layer}));
    end
end
