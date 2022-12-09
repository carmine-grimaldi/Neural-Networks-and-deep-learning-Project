function [derW,derB] = calcolaDerivate(net, delta, input)
    layersNum = net.getLayersNum();
    derW = cell(layersNum-1, 1);
    derB = cell(layersNum-1, 1);

    z = input;
    for layer = 1 : layersNum-1
        derW{layer} = delta{layer} * z';
        derB{layer} = sum(delta{layer}, 2);
        z = net.getOutput(layer);
    end
end