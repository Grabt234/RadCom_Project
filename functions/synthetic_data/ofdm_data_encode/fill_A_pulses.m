function L_encode = fill_A_pulses(L_encode,dab_mode)
    % ---------------------------------------------------------------------    
    % fill_A_pulses: fills up remaining pulses with 1's
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > L_encode - n vectors of length L(L excludes null) phase codes
    %  > dab_mode - describtion of DAB modulation parameters
    %
    %  Outputs
    %  > A_pulses - inter number of symbols for ineger pulses
    %
    % --------------------------------------------------------------------- 
    
    %L excludes null)
    number_pulses = size(L_encode,1)/(dab_mode.L);
    
    %additional symbols requires to make integer number of frames
    %only single prs per frame
    required_symbols = ((number_pulses-floor(number_pulses)))*(dab_mode.L);
    
    %see below
    additional = ones(required_symbols, dab_mode.K);
    
    %appending symbols to make integer number of pulses
    L_encode = [L_encode ; additional];  
    
end




















