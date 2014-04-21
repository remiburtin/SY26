function [image_quant disto] = quant_uni(image, debit)
    img = imread(image);
    composantes = size(img, 3);

    if (composantes == 3)
        img = rgb2gray(img);
    end

    dim = size(img,1)*size(img,2);
    list=reshape(double(img), 1, dim);
    
    partition = linspace(0,255, 2^debit);
    partition = partition(2:2^debit-1);
    
    codebook(1) = partition(1)/2;
    codebook(2^debit-1) = (partition(2^debit-2) + 255) / 2;
    for i=2:(2^debit-2),
        codebook(i) = (partition(i-1) + partition(i)) / 2 ;
    end
    
    [index, image_quant] = quantiz(list, partition, codebook);
    
    disto = mean((list-image_quant).^2);
end
