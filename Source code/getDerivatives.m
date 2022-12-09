function derivatives = getDerivatives(fun)
    addpath('Activation Functions', 'Error Functions');

    f = {@sigmoid, @relu, @lrelu, @identity, @elu, @sumOfSquares, @crossEntropy, @crossEntropySoftMax};
    df = {@derivSigmoid, @derivRelu, @derivLRelu, @derivIdentity, @derivElu, @derivSumOfSquares, @derivCrossEntropy, @derivCrossEntropySoftMax};

    for actualFunction = 1 : length(f)
        if isequal(fun, f{actualFunction})
            derivatives = df{actualFunction};
            break;
        end
    end
end

