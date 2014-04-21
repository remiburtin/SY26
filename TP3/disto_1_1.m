function [nmse snr] = disto(image, nbval)
    img = imread(image);
    
    % Conversion image en gris
    composantes = size(img, 3);
    if (composantes == 3)
        img = rgb2gray(img);
    end

    % Conversion image en liste
    dim = size(img,1)*size(img,2);
    list=reshape(double(img), 1, dim);
    
    % Codage arithmetique via quantification de Lloyd-Max
    [part, codebook, dist] = lloyds(list, nbval);
    
    % Distorsion normalisee
    nmse = dist/var(list);
    % Rapport signal bruit
    snr = -10*log10(nmse);
    
    return;
end
