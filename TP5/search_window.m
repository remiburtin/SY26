function [ window, orig_x, orig_y ] = search_window( img, W, M, i, j )
    %i,j : indices dans l'image, du pixel en haut à gauche du bloc
    %M   : largeur/hauteur du bloc
    %W   : taille zone de recherche
    y1 = i-W;
    if y1 <= 0
        y1 = 1;
    end;
    y2 = i + (M-1) + W;
    if y2 > size(img,1)
        y2 = size(img,1);
    end;
    
    x1 = j-W;
    if x1 <= 0
        x1 = 1;
    end;
    x2 = j + (M-1) + W;
    if x2 > size(img,2)
        x2 = size(img,2);
    end;
    
    %indices du bloc courant dans la fenetre de recherche (utile pour le
    %calcul du vecteur de mouvement)
    orig_y = (i - y1)+1;
    orig_x = (j - x1)+1;
    
    %recuperation de la fenetre de recherche
    window = img(y1:y2,x1:x2);
end

