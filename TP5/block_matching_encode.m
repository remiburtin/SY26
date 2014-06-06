function [ time, output_image ] = block_matching_encode( img_ref, img, M, W )
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
    
    img = padarray(img,[pad_y pad_x],0,'post');
    img_ref = padarray(img_ref,[pad_y pad_x],0,'post');
    output_image = img_ref;
    
    tic
    for i=1:M:size(img,1),
        for j=1:M:size(img,2),
            block = img(i:(i+M)-1,j:(j+M)-1);
            (i/size(img,1))*100
            (j/size(img,2))*100
            [window, orig_x, orig_y] = search_window(img_ref,W,M,i,j);
            [delta_x, delta_y, error] = block_matching(block,window,orig_y,orig_x);
            
            output_image(i+delta_y : i+M-1+delta_y , j+delta_x : j+M-1+delta_x) = block-error;
        end;
    end;
    time = toc;
end

