function w = rescale_to_unity_weights(w)
    % ---------------------------------------------------------------------    
    % rescale_to_unity_weights: rescales weights array to summed unity
    %                               value
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > w - (LxN) unscaled inputed frequency weight array
    %  Outputs
    %   > (w) a rescaled frequency weight array when summed has unity value
    %
    % ---------------------------------------------------------------------
    
    %normaliseing wrt to all carriers
    %assumes weights themselves are normalised
    w = w/length(w);

end