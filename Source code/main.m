 function [accuracy, minErrTrain, minErrValid] = main(layers, funzErr)
    % Recupero training e test set dal dataset MNIST
    training = loadMNIST('MNIST dataset/train-images.idx3-ubyte','MNIST dataset/train-labels.idx1-ubyte');
    test = loadMNIST('MNIST dataset/test-set-10k-images.idx3-ubyte','MNIST dataset/test-set-10k-labels.idx1-ubyte');
    
    % Inizializzo gli iperparametri
    sizeTraining=50000;
    sizeTest=10000;
    sizeValidation=10000;
    nEpoche=200; % numero di epoche
    eta=0.00001; % learning rate
    etaP=1.2; % eta+ per algoritmo di rProp
    etaN=0.5; % eta- per algoritmo di rProp
    variation=0.001; % per l'inizializzazione delle variazioni dei pesi
    soglia=10; % criterio di early stopping
    
    % Shuffle
    training = shuffleSet(training);
    test = shuffleSet(test);
    
    % Sostituisco l'etichetta 0 con 10
    training.labels(training.labels==0)=10;
    test.labels(test.labels==0)=10;
    
    % Estrapolo il validation set dal training set
    validation = subSet(training, 1, sizeValidation);
    
    % Recupero una parte del training set e test set
    training = subSet(training, sizeValidation + 1, sizeValidation + sizeTraining);
    test = subSet(test, 1 , sizeTest);
    
    % Riadatto le etichette
    training.labels = getOneHotEncodingFromLabels(training.labels);
    validation.labels = getOneHotEncodingFromLabels(validation.labels);
    test.labels = test.labels';
    
    addpath('Activation Functions', 'Error Functions');
    
    % Creazione della rete neurale:
    %{
    layersVector = [784 50 10];
    functionsVector = {@relu @identity};
    funzErr = @crossEntropySoftMax;
    
    layers = cell(length(layersVector), 1);
    for layer = 1 : length(layersVector)-1
        layers{layer} = struct('neuronsNum', layersVector(layer), 'activationFunction', functionsVector(layer));
    end
    layers{layer+1} = struct('neuronsNum', layersVector(layer+1), 'activationFunction', libpointer);
    %}
    net = NeuralNetwork(layers);
    
    % Addestramento della rete neurale
    [net, minErrValid, minErrTrain] = trainingBatch(net, funzErr, training, validation, nEpoche, variation, eta, etaP, etaN, soglia);
    
    % Calcolo accuratezza
    accuracy = testing(net, test, funzErr);
    fprintf("accuracy: %.4f\n", accuracy);
end

function set = shuffleSet(dataSet)
    index = randperm(size(dataSet.images, 2));
    set.images = dataSet.images(:,index);
    set.labels = dataSet.labels(index,:);
end

function subSet = subSet(set, startId, endId)
    subSet.images = set.images(:,startId:endId);
    subSet.labels = set.labels(startId:endId,:);
end