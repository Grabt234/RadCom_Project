function L_encode = fill_A_pulses(L_encode,dab_mode)
    % ---------------------------------------------------------------------    
    % fill_A_pulses: fills up remaining pulses with 1's
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > L_encode - n vectors of length L phase codes
    %  > dab_mode - describtion of DAB modulation parameters
    %
    %  Outputs
    %  > A_pulses - inter number of symbols for ineger pulses
    %
    % --------------------------------------------------------------------- 
    %not including null symbol
    number_pulses = size(L_encode,1)/(dab_mode.L-1);
    
    %additional symbols requires to make integer number of frames
    %only single prs per frame
    required_symbols = (number_pulses-floor(number_pulses))*(dab_mode.L-1);
    
    %see below
    additional = ones(required_symbols, dab_mode.K);
    
    %appending symbols to make integer number of pulses
    L_encode = [L_encode ; additional];  
    
end




















