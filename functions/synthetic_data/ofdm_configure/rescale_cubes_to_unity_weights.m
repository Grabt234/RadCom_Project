function W_cubes = rescale_cubes_to_unity_weights(W_cubes, F_inter, F_intra)
    % ---------------------------------------------------------------------    
    % rescale_frame_to_unity_weights: rescales all frame weight cubes to 
    %                               unity values               
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > W_cubes - unscaled inputed frame frequency weight cubes
    %   > F_inter - number of multipulse frames
    %   > F_intra - number of pulses within a frame
    %
    %  Outputs
    %   > W_cubes rescaled to unity frequency cubes corresponding to each
    %                           multipulse frame
    %
    % ---------------------------------------------------------------------
    
    for f = 1:F_inter
    
           %iterating through individual cubes corresponding to phase codes
           %within a specific frame
        W_cubes(:,:,:,f) = rescale_cube_to_unity_weights( ...
                                                W_cubes(:,:,:,f),F_intra);
        
    end

end