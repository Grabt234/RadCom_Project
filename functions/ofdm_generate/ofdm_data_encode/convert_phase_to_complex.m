function A = convert_phase_to_complex(B)
    % ---------------------------------------------------------------------    
    % convert_phase_to_complex: Takes an angle an converts it to a complex
    %                               number with a unity magnitude
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > B - Column vector of phases                       
    %  
    %  Outputs
    %  > A - Column/Vector of complex scaling factors for ofdm signals
    %
    % ---------------------------------------------------------------------
   
   [A_r, A_i] = pol2cart(B,1);
   A = A_r + 1i.*A_i;

end