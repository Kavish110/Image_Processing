% Function to reconstruct image with specified number of high frequency subbands set to zero
function reconstructed = reconstructModified(A, H, V, D, num_zero_bands)
    wname='haar';
    % Make copies of the coefficient cells
    A_mod = A;
    H_mod = H;
    V_mod = V;
    D_mod = D;
    
    % Counter for bands set to zero
    bands_set = 0;
    level = 1;
    
    % Set specified number of highest frequency subbands to zero
    while bands_set < num_zero_bands && level <= 4
        remaining_bands = num_zero_bands - bands_set;
        
        if remaining_bands >= 3
            % Set all three detail subbands at this level to zero
            H_mod{level}(:,:,1) = zeros(size(H_mod{level}(:,:,1)));
            V_mod{level}(:,:,1) = zeros(size(V_mod{level}(:,:,1)));
            D_mod{level}(:,:,1) = zeros(size(D_mod{level}(:,:,1)));
            bands_set = bands_set + 3;
        else
            % Set remaining bands to zero (if any)
            if remaining_bands > 0
                if remaining_bands >= 1
                    H_mod{level}(:,:,1) = zeros(size(H_mod{level}(:,:,1)));
                end
                if remaining_bands >= 2
                    V_mod{level}(:,:,1) = zeros(size(V_mod{level}(:,:,1)));
                end
                bands_set = bands_set + remaining_bands;
            end
        end
        level = level + 1;
    end
    
    % Reconstruct from level 4 to level 1
    temp = iswt2(A_mod{4}, H_mod{4}, V_mod{4}, D_mod{4}, wname);
    temp = iswt2(cat(3,temp), H_mod{3}, V_mod{3}, D_mod{3}, wname);
    temp = iswt2(cat(3,temp), H_mod{2}, V_mod{2}, D_mod{2}, wname);
    reconstructed = iswt2(cat(3,temp), H_mod{1}, V_mod{1}, D_mod{1}, wname);
end