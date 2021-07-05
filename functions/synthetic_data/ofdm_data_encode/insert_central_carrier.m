function A_cube = insert_central_carrier(A_cube, dab_mode)
    % ---------------------------------------------------------------------    
    % insert_cental_carrier: Inserts the switched off central carrier into 
    %                           phase code cube, prevents loss of info
    %                                             
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > A_cube - ( F x (LxK) ) phase codes
    %  Outputs 
    %  > A_cube - ( F x (LxK_0)) phase codes with off central carrier     
    %
    % ---------------------------------------------------------------------
    
    K = dab_mode.K
    F = size(A_cube, 1);
    L = size(A_cube,2)
    size(A_cube)
    %storing first half of matrix
    A_cube_half_left = A_cube( : , :, 1:K/2 );
    size(A_cube_half_left)
    %storing second half of matrix
    A_cube_half_right = A_cube( : , : ,K/2+1:end);
    size(A_cube_half_right)
    %creatting central "off" carrier phase codes
    A_cube_zero_centre = zeros(F,L,1);
    
    %rejoin all array with off carriers in the centre
    A_cube = cat(3, A_cube_half_left,  A_cube_zero_centre,  A_cube_half_right);
    

    
end