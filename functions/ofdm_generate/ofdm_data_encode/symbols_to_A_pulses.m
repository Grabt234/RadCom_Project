function A_pulses = symbols_to_A_pulses(L_dpsk,dab_mode)
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
    
    %including null symbol
    %each pulse must consistently have same number of symbols 
    
    %should be integer at this point
    number_pulses = size(L_dpsk,1)/dab_mode.L;
    
    %pulses - symbols - elements
    A_pulses = zeros(number_pulses, dab_mode.L ,size(L_dpsk,2));
    
    for i = 1:size(L_dpsk,1)
        
        pulse_number = ceil(i/dab_mode.L)
        
        symbol_number = mod((i - (pulse_number-1)*dab_mode.L),dab_mode.L+1) 
       
        A_pulses(pulse_number, symbol_number, :) =  shiftdim(L_dpsk(i,:),1);
        
    end
  
end




















