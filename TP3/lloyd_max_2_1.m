function [image_quant disto] = quant_lloyd(image, debit)
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
    
    % Initialisation condition d'arret
    oldDisto = 9999; % doit etre >> a la premiere disto calculee
    diffDisto = 9999; % Doit etre > a 0.1 pour entrer dans la boucle
    
    % Condition de convergence
    while diffDisto > 0,1;
        
        for j=1:(2^debit) %calcul des ri
            % v = index des elements appartenant a l'intervalle j dans list
            v = find(list >= partition(j) & list <= partition(j+1));
            if (isempty(v)) % intervalle vide
                codebook(j) = (partition(j) + partition(j + 1)) / 2;
            else
                codebook(j) = mean(list(v));
            end
        end
        
        for j=2:(2^debit) %calcul des di
            partition(j) = (codebook(j) + codebook(j - 1))/2;
        end
        
        % Quantification
        [~, image_quant] = quantiz(list, partition(2:2^debit), codebook);
        % Calcul de la distorsion
        disto = mean((list-image_quant).^2);
        
        %Mise a jour condition d'arret
        diffDisto = oldDisto - disto;
        oldDisto = disto;
    end
    
    % Reconstruction de l'image en vecteur
    image_quant = reshape(image_quant, size(img,1), size(img,2));
end