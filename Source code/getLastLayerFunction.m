function activationFunction = getLastLayerFunction(errorFun)
    addpath('Activation Functions', 'Error Functions');
    
    f = {@crossEntropy, @crossEntropySoftMax, @sumOfSquares};
    af = {@sigmoid, @softmax, @sigmoid};

    for actualFunction = 1 : length(f)
        if isequal(errorFun, f{actualFunction})
            activationFunction = af{actualFunction};
            break;
        end
    end
end