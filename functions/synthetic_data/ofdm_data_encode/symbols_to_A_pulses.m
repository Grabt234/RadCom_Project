function A_pulses = symbols_to_A_pulses(L_encode,dab_mode)
    % ---------------------------------------------------------------------    
    % symbols_to_A_cubes: converting n symols into phase code cubes 
    %                           (rounding up to nearest number of frames)
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > L_encode - n vectors of length L phase codes
    %  > dab_mode - describtion of DAB modulation parameters
    %
    %  Outputs
    %  > A_pulses - phase cubes with L-1 (excluding null symbol) to encode
    %                   an OFDM symbol 
    %
    % --------------------------------------------------------------------- 
    
    %not including null symbol
    %each pulse must consistently have same number of symbols 
    %(even if filled with noise)
    A_pulses = reshape(L_encode,[],dab_mode.L,dab_mode.K);
    
end




















