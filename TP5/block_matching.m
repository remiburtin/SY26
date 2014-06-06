function [ delta_x, delta_y, error ] = block_matching( current_block, search_window, orig_i, orig_j )
    %initialisation du MSD minimum à Infini
    min_msd = inf;
    
    M = size(current_block,1);
    
    for i=1:(size(search_window,1)- M) + 1
        for j=1:(size(search_window,2)- M) +1
            %recuperation d'un bloc dans la fenetre de recherche
            block = search_window(i:(i+M)-1,j:(j+M)-1);
            
            %calcul du msd entre le bloc courant et le bloc que nous venons
            %de recuperer dans la fenetre de recherche
            msd = compute_msd(current_block, block);

            if msd < min_msd
                %sauvegarde du msd
                min_msd = msd;
                
                %calcul du vecteur de mouvement
                delta_y = i - orig_i;
                delta_x = j - orig_j;
                
                %calcul de l'erreur de prediction
                error = current_block - block;
            end;
        end;
    end;
end

