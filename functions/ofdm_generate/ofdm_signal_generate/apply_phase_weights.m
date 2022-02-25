function g = apply_phase_weights(g, a)
    % ---------------------------------------------------------------------    
    % apply_freq_weights: generates an array of phase adjusted complex 
    %                       time domain      
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > g = (N x t) matrix of complex time domain values for carriers
    %   > a = (N x 1) matrix of phases with magnitude 1

    %  Outputs
    %   > g = (N x t) matrix of phase adjusted time domain values for 
    %           carriers
    % ---------------------------------------------------------------------
   g =  g.*a;

end