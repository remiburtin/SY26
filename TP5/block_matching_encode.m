function [ time, output_image, error, msd ] = block_matching_encode( img_ref, img, N, W )
    M = 2*N+1;

    %Conversion en niveaux de gris
    img_ref = rgb2gray(img_ref);
    img = rgb2gray(img);
    
    %padding de l'image (on ajoute des 0 pour que la largeur/hauteur soit
    %multiple de M
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
    
    %affichage de la difference en tre l'image courante et l'image de
    %reference
    figure('name','Diff current vs ref');
    imshow(((img-img_ref)+128)/255);
    
    %Initialisation matrice contenant les composantes x et y des vecteurs
    %de mouvement
    matx = zeros(size(img,1)/M, size(img,2)/M);
    maty = zeros(size(img,1)/M, size(img,2)/M);
    
    %timer
    tic
    
    k=1;
    for i=1:M:size(img,1),
        l=1;
        for j=1:M:size(img,2),
            %extraction bloc courant
            block = img(i:(i+M)-1,j:(j+M)-1);
            
            %calcul de la fenetre de recherche
            [window, orig_x, orig_y] = search_window(img_ref,W,M,i,j);
            
            %recherche du bloc qui se rapproche le plus du bloc courant
            %dans la fenetre de recherche
            [delta_x, delta_y, error] = block_matching(block,window,orig_y,orig_x);
            
            %on met le vecteur de mouvement dans des matrices (une pour la
            %composante x et une autre pour la y)
            matx(k,l) = delta_x;
            maty(k,l) = delta_y;
            
            l = l + 1;
            
            %on recupere le bloc que nous avons trouve dans l'image de ref
            %grace au vecteur de mouvement et le mettons à la place qu'il
            %devrait avoir dans l'image courante
            output_image(i:(i+M)-1,j:(j+M)-1) = img_ref(i+delta_y : i+M-1+delta_y , j+delta_x : j+M-1+delta_x);
            
        end;
        k = k + 1;
    end;
    time = toc;
    
    %calcul et affichage de l'erreur de prediction
    error = (img - output_image)+128;
    figure('name','Erreur de prediction');
    imshow(error/255);
    
    msd = compute_msd(img, output_image);
    
    %champ de vecteur
    figure('name','Vecteurs de mouvement');
    quiver(matx/M,maty/M);
    %inversion de l'axe des y
    axis ij;
    
    
    %affichage de l'image predite
    figure('name','Image prédite');
    imshow(output_image/255);
end

