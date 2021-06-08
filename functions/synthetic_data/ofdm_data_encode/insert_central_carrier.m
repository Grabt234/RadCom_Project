function A_cube = insert_central_carrier(A_cube,L, N,F)
    % ---------------------------------------------------------------------    
    % insert_cental_carrier: Inserts the switched off central carrier into 
    %                           phase code cube, prevents loss of info
    %                                             
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > A_cube - ( (LxN) x F) phase codes
    %  Outputs 
    %  > A_cube - ( (LxN_0) x F) phase codes with off central carrier     
    %
    % ---------------------------------------------------------------------
    
    %storing first half of matrix
    A_cube_half_left = A_cube(1:end , 1:N/2 , 1:end );
    
    %storing second half of matrix
    A_cube_half_right = A_cube( 1:end ,N/2+1:end , 1:end);
    
    %creatting central "off" carrier phase codes
    A_cube_zero_centre = zeros(L,1,F);
    
    %rejoin all array with off carriers in the centre
    A_cube = [A_cube_half_left  A_cube_zero_centre  A_cube_half_right];
    

    
end