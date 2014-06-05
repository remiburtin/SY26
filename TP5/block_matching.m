function [ delta_x, delta_y, error ] = block_matching( current_block, search_window, orig_i, orig_j )
    min_msd = inf;
    M = size(current_block,1);
    
    for i=1:(size(search_window,1)- M) + 1
        for j=1:(size(search_window,2)- M) +1
            
            block = search_window(i:(i+M)-1,j:(j+M)-1);
            msd = compute_msd(current_block, block);
            
            if msd < min_msd
                min_msd = msd;
                delta_y = i - orig_i;
                delta_x = j - orig_j;
                error = current_block - block;
            end;
        end;
    end;
end

