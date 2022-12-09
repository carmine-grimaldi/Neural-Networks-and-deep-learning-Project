function targets = getOneHotEncodingFromLabels(labels)
    labelsNumber = length(labels);
    classNumber = length(unique(labels));
    targets = zeros(classNumber, labelsNumber);
    
    for label = 1 : labelsNumber
        targets(labels(label), label) = 1;
    end
end