function L_dpsk = add_null(L_dpsk)
    % ---------------------------------------------------------------------    
    % add_null: Adding in first null symbols to phase cube
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > A_cube - phase code cube without null symbol
    %
    %  Outputs
    %  > A_cube - phase code cube with null symbol
    %
    % ---------------------------------------------------------------------
    
    %generating null phase codes
    null_symbol = zeros(1, size(L_dpsk,2));
    
    %oncatnating null symbol
    L_dpsk = [null_symbol; L_dpsk];
    
end

















