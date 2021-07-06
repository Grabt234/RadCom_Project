function A_cube = add_prs_A_cube(L_encode,dab_mode)
    % ---------------------------------------------------------------------    
    % add_prs_A_cube: Adding in prs then reshaping into cube without
    %                       null symbol
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > L_encode - n vectors of length L phase codes
    %  > dab_mode - describtion of DAB modulation parameters
    %
    %  Outputs
    %  > 
    %
    % ---------------------------------------------------------------------
    
    %generating prs (and remove center carrier to be added in later)
    prs = build_prs_phase_codes(dab_mode);
    
    %cutting to remove central carrier
    prs_left = prs(1:(length(prs)+1)/2-1);
    prs_right = prs((length(prs)+1)/2+1:end);
    
    prs = [prs_left prs_right];
    
    %prepending prs
    A_cube = [prs ; L_encode];
    
    
end

















