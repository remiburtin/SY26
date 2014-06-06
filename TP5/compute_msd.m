function msd = compute_msd( current_block, block )
    M = size(block,1);
    msd = 1/M^2;
    somme = 0;
    
    for i=1:M,
        for j=1:M,
            somme = somme + (current_block(i,j)-block(i,j))^2;
        end;
    end;
    msd = msd * somme;
end

