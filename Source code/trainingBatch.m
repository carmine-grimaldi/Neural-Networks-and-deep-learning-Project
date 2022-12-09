function [finalNet, minErrValid, minErrTrain] = trainingBatch(net, errorFunction, trainingSet, validationSet, nEpoche, variation, eta, etaP, etaN, soglia)
    addpath('Activation Functions');

    % Inizializzazione dei delta per l'aggiornamento dei pesi tramite rProp
    [deltaW, deltaB] = initDelta(net, variation);
    
    % Array degli errori per training set e validation set
    errTrain = zeros(1, nEpoche);
    errValid = zeros(1, nEpoche);
    minErrTrain = realmax;
    minErrValid = realmax;

    % Addestramento
    e = 1;
    stopCriterion = 0;

    while (e<=nEpoche && stopCriterion==0)
        net = forwardPropagation(trainingSet.images, net, errorFunction);
        delta = backPropagation(net, trainingSet.labels, errorFunction);
        [derW, derB] = calcolaDerivate(net, delta, trainingSet.images);

        if(e == 1)  % Aggiornamento dei pesi tramite Discesa del gradiente standard
            net = gradientDescent(net, derW, derB, eta);
        else % Aggiornamento dei pesi tramite RProp
            [net, deltaW, deltaB] = rprop(net, derW, derB, precDerW, precDerB, deltaW, deltaB, etaP, etaN);
        end

        % Le derivate correnti saranno le derivate precedenti alla prossima epoca
        precDerW = derW;
        precDerB = derB;

        % Calcolo l'errore sul training set
        net = forwardPropagation(trainingSet.images, net, errorFunction);
        errTrain(e) = errorFunction(net.getOutput(net.getLayersNum()-1), trainingSet.labels)/size(trainingSet.labels,2);

        % Calcolo l'errore sul validation set
        net = forwardPropagation(validationSet.images, net, errorFunction);
        errValid(e) = errorFunction(net.getOutput(net.getLayersNum()-1), validationSet.labels)/size(validationSet.labels,2);
        
        % Se all'epoca corrente ottengo un errore minore del minimo ottenuto, 
        % la rete corrente diventa la migliore.
        if errValid(e) < minErrValid
            minErrValid = errValid(e);
            finalNet = net;
        end

        % Calcolo l'errore minimo sul training set
        if errTrain(e) < minErrTrain
            minErrTrain = errTrain(e);
        end

        % Stampa degli errori
        fprintf("Epoca: %d trainErr: %.7f validErr: %.7f\n", e, errTrain(e), errValid(e));

        % Criterio di fermata
        loss = abs(100*((minErrValid/errValid(e))-1));
        if(loss > soglia)
            stopCriterion = 1;
        end
        e=e+1;
    end
    
    % Stampa errore minimo
    fprintf("Errore minimo validation: %.7f\n", minErrValid);
    fprintf("Errore minimo training: %.7f\n", minErrTrain);
    figure 
    x=1:e-1;
    plot(x, errTrain(x), x, errValid(x));
    xlabel('Epoche ') % x-axis label
    ylabel('Valori di errore ') % y-axis label
    legend('Errore Training Set','Errore Validation Set')
end