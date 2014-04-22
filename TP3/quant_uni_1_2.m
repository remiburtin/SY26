function [image_quant disto] = quant_uni(image, debit)
    img = imread(image);
    % Conversion en gris si couleur
    composantes = size(img, 3);
    if (composantes == 3)
        img = rgb2gray(img);
    end
    % Conversion image en vecteur ligne
    dim = size(img,1)*size(img,2);
    list=reshape(double(img), 1, dim);
    
    % Construction des partitions
    partition = linspace(0,255, 2^debit+1);

    % Creation des valeurs de reconstruction
    for i=1:(2^debit),
        codebook(i) = (partition(i) + partition(i+1)) / 2 ;
    end
    
    % Quantiz utilise -Inf et +Inf pour borner la partition.
    partition = partition(2:2^debit); 
    
    % Quantification
    [~, image_quant] = quantiz(list, partition, codebook);
    
    partition
    codebook
    
    % Calcul de la distorsion
    disto = mean((list-image_quant).^2);
    
    % Reconstruction de l'image en vecteur
    image_quant = reshape(image_quant, size(img,1), size(img,2));
end
