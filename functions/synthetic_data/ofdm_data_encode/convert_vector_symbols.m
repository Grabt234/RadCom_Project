function L_encode = convert_vector_symbols(A,dab_mode)
    % ---------------------------------------------------------------------    
    % convert_vector_symbols: Takes an array of phase codes and converts
    %                           them into an array of symbols
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > A - vector of phase codes
    %  > dab_mode - describtion of DAB modulation parameters
    %
    %  Outputs
    %  > return n vectors of length L phase codes
    %
    % ---------------------------------------------------------------------
    %% ASSIGNING CONSTANTS  

    %carriers per symbol
    K = dab_mode.K;

    %% CALCULATING REQUIRED PULSES

    %number of complete symbols to be encoded
    n = ceil(length(A)/K);

    %appending to create integer number of symbols
    size_filler = n*K - length(A);
    fill = ones(size_filler,1);
    
    %phase codes that are integer number of symbols
    A = [A; fill];

    %% SPLITTING INTO INDEPENDANT SYMBOLS
    
    %does not include null symbol or prs
    L_encode = reshape(A,[],K);
    
end

















