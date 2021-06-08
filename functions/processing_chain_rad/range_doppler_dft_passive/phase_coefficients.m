function coefficients = phase_coefficient(phase_cube)
    % ---------------------------------------------------------------------    
    % phase_coefficient: generates and returns Autocorrelation peak for 
    %                     the sequence of phase codes on Subcarrier in a 
    %                      Pulse
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > phase_cube:    cube of phase codes [frame x symbol x carrier]
    %   
    %  Outputs
    %   < co 
    %
    % ---------------------------------------------------------------------    
   
    phase_cube = phase_cube(:,:)*conj(phase_cube(:,:)).'
    coefficients = sum(phase_cube,2);
end