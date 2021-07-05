function A_cubes = symbols_to_A_cubes(L_encode,dab_mode)
    % ---------------------------------------------------------------------    
    % symbols_to_A_cubes: converting n symols into phase code cubes 
    %                           (rounding up to nearest number of cubes)
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > L_encode - n vectors of length L phase codes
    %  > dab_mode - describtion of DAB modulation parameters
    %
    %  Outputs
    %  > A_cubes - phase cubes with L-1 (excluding null symbol) to encode
    %                   an OFDM symbol 
    %
    % ---------------------------------------------------------------------
    
    %not including null symbol
    number_cubes = size(L_encode,1)/(dab_mode.L-1);
    
    required_symbols = (number_cubes-floor(number_cubes))*(dab_mode.L-1);
    
    additional = ones(required_symbols, dab_mode.K);
    
    L_encode = [L_encode ; additional];
    
    A_cubes = reshape(L_encode,[],dab_mode.L-1,dab_mode.K);
    
end

















