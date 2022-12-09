clear;
clc;

addpath('Activation Functions', 'Error Functions');

activactionFunctions = {@sigmoid @relu};
errorFunction = @crossEntropySoftMax;

nomeFile = 'Testing.xlsx';
table = readtable(nomeFile, 'sheet', 2, 'PreserveVariableNames', true);
tests = table{:,1};
for test = 1 : length(tests)
    for actualFunction = 1 : length(activactionFunctions)
        activactionFunction = activactionFunctions{actualFunction};

        numberOfNeurons = str2double(split(char(tests{test}), "-"));
        numberOfLayer = length(numberOfNeurons) + 2;
        layers = cell(numberOfLayer, 1);
        layers{1} = struct('neuronsNum', 784, 'activationFunction', activactionFunction);
    
        fprintf("%d)Test: %s %s\n", test, tests{test}, func2str(activactionFunction));
        
        for layer = 2 : numberOfLayer - 1
            layers{layer} = struct('neuronsNum', numberOfNeurons(layer - 1), 'activationFunction', activactionFunction);
        end
        layers{numberOfLayer - 1}.activationFunction = @identity;
        layers{numberOfLayer}=struct('neuronsNum', 10, 'activationFunction', libpointer);
    
        if (actualFunction == 1) 
            f = figure;
            subplot(1,2,1);
        else 
            subplot(1,2,2);
        end
        
        [accuracy, minErrTrain, minErrValid] = main(layers, errorFunction);

        pbaspect([1 1 1]);

        if (actualFunction == 1)
            col = 0;
            title(strcat(tests{test},' sigmoide'));
        else 
            col = 3;
            title(strcat(tests{test},' relu'));
            % exportgraphics(f, strcat('./grafici/',strcat(tests{test},'.jpg')), 'Resolution',300);
            close all;
        end

        table{test, col + 2} = accuracy;
        table{test, col + 3} = minErrTrain;
        table{test, col + 4} = minErrValid;
    end
end

% writetable(table, nomeFile,'sheet',2);