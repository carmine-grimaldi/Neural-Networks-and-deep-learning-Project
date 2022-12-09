function output = loadMNIST(imagesFilename, labelsFilename)
	% Recupero delle immagini sotto forma di una matrice 
	% 28x28x[numero di immagini del dataset] contenente le immagini del dataset
    fp = fopen(imagesFilename, 'rb');
    assert(fp ~= -1, ['Could not open ', imagesFilename, '']);

    magic = fread(fp, 1, 'int32', 0, 'ieee-be');
    assert(magic == 2051, ['Bad magic number in ', imagesFilename, '']);

    numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
    numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
    numCols = fread(fp, 1, 'int32', 0, 'ieee-be');

    images = fread(fp, inf, 'unsigned char');
    images = reshape(images, numCols, numRows, numImages);
    images = permute(images,[2 1 3]);

    fclose(fp);

    % Reshape to #pixels x #examples
    images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));
    % Convert to double and rescale to [0,1]
    images = double(images) / 255;
	
	% Recupero delle labels sotto forma di una matrice [numero di immagini del dataset]x1 
    % contenente le labels associate alle immagini del dataset
    fp = fopen(labelsFilename, 'rb');
    assert(fp ~= -1, ['Could not open ', labelsFilename, '']);

    magic = fread(fp, 1, 'int32', 0, 'ieee-be');
    assert(magic == 2049, ['Bad magic number in ', labelsFilename, '']);

    numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');

    labels = fread(fp, inf, 'unsigned char');

    assert(size(labels,1) == numLabels, 'Mismatch in label count');

    fclose(fp);

    output.images = images;
    output.labels = labels;
end