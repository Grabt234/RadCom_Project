function W_cube = rescale_cube_to_unity_weights(W_cube,F)
    % ---------------------------------------------------------------------    
    % rescale_frame_to_unity_weights: rescales frame weights cube to unity
    %                               values               
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > W_cube - unscaled inputed frame frequency weight cube
    %  Outputs
    %   > W_cube a rescaled to unity frequency cube
    %
    % ---------------------------------------------------------------------
    
    for f = 1:F
    
        W_cube(:,:,f) = rescale_to_unity_weights(W_cube(:,:,f));
        
    end

end     