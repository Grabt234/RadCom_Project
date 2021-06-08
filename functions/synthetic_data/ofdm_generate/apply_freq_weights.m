function g = apply_freq_weights(g, w)
    % ---------------------------------------------------------------------    
    % apply_freq_weights: generates an array of scaled complex time domain
    %                   
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > g = (N x t) matrix of complex time domain values for carriers
    %   > w = (N x 1) matrix of magnitude scalars for subcarrier n

    %  Outputs
    %   > g = (N x t) matrix of scales time domain values for carriers
    %
    % ---------------------------------------------------------------------
    
    g =  g.*w;

end