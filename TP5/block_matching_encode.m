function [ time, output_image, error ] = block_matching_encode( img_ref, img, M, W )
    img_ref = rgb2gray(img_ref);
    img = rgb2gray(img);
    
    pad_y = mod(size(img,1),M);
    if pad_y > 0
        pad_y = M - pad_y;
    end;
    
    pad_x = mod(size(img,2),M);
    if pad_x > 0
        pad_x = M - pad_x;
    end;
    
    img = double(padarray(img,[pad_y pad_x],0,'post'));
    img_ref = double(padarray(img_ref,[pad_y pad_x],0,'post'));
    
    matx = zeros(size(img,1)/M, size(img,2)/M);
    maty = zeros(size(img,1)/M, size(img,2)/M);
    
    tic
    k=1;
    for i=1:M:size(img,1),
        l=1;
        for j=1:M:size(img,2),
            block = img(i:(i+M)-1,j:(j+M)-1);
            [window, orig_x, orig_y] = search_window(img_ref,W,M,i,j);
            [delta_x, delta_y, error] = block_matching(block,window,orig_y,orig_x);
            matx(k,l) = delta_x;
            maty(k,l) = delta_y;
            output_image(i:(i+M)-1,j:(j+M)-1) = img(i+delta_y : i+M-1+delta_y , j+delta_x : j+M-1+delta_x) + error;
            l = l + 1;
        end;
        k = k + 1;
    end;
    time = toc;
    error = img - output_image;
    
    %champ de vecteur
    quiver(matx/M,maty/M);
    axis ij;
    figure;
    imshow(output_image/255);
end

