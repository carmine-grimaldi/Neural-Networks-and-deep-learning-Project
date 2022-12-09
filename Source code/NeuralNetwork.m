classdef NeuralNetwork
        
    properties (Access = private)
        % Array di celle dove ogni cella è una matrice 2D
        weight
        % Array di bias per ogni strato
        bias        
        % Array di struct contenente informazioni riguardo la struttura della rete:
        % layersInfo.activationFunction
        % layersInfo.neuronsNum
        layersInfo
        % Numero di layers per ogni strato della rete (inclusi input/output layer)
        layersNum
        % Array contenente i valori di attivazione dei neuroni per ciascuno strato
        activationValue
        % Array contenente i valori di output dei neuroni per ciascuno strato
        output
    end
    
    methods (Access = public)
        function net = NeuralNetwork(layersInfo)
            net.layersNum = length(layersInfo); 
            net.layersInfo = layersInfo;
            net.bias = cell(net.layersNum-1, 1);
            net.weight = cell(net.layersNum-1, 1);

            net.activationValue = cell(net.layersNum-1, 1);
            net.output = cell(net.layersNum-1, 1);

            net = net.initializeParameters(0.01);
        end

        function layersNum = getLayersNum(net)
            layersNum = net.layersNum;
        end

        function neuronsNum = getNeuronsNum(net, layerID)
            neuronsNum = net.layersInfo{layerID}.neuronsNum;
        end

        function activationFunction = getActivationFunction(net, layerID)
            activationFunction = net.layersInfo{layerID}.activationFunction;
        end

        function w = getNetWeight(net, layer)
            w = net.weight{layer};
        end

        function b = getNetBias(net, layer)
            b = net.bias{layer};
        end
        
        function net = setActivationValue(net, layer, a)
            net.activationValue{layer} = a;
        end

        function a = getActivationValue(net, layer)
            a = net.activationValue{layer};
        end

        function net = setOutput(net, layer, out)
            net.output{layer} = out;
        end

        function o = getOutput(net, layer)
            o = net.output{layer};
        end

        function net = setNetWeight(net, layer, w)
            net.weight{layer} = w;
        end

        function net = setNetBias(net, layer, b)
            net.bias{layer} = b;
        end
    end
    
    methods (Access = private)
        function net = initializeParameters(net, w)
            neuronsNumPrevLayer = net.layersInfo{1}.neuronsNum;
            for layer = 1 : (net.layersNum-1)
               neuronsNumCurrLayer = net.layersInfo{layer+1}.neuronsNum;
               net.weight{layer} = w * randn(neuronsNumCurrLayer, neuronsNumPrevLayer);
               net.bias{layer} = w * randn(neuronsNumCurrLayer, 1);
               neuronsNumPrevLayer = neuronsNumCurrLayer;
            end
        end
    end
end