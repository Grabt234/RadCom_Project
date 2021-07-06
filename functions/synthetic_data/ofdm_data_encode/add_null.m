function A_cube = add_null(A_cube)
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
    
    
    null_symbols = zeros(size(A_cube,1), 1, size(A_cube,3));
    
    A_cube = cat(2,null_symbols, A_cube)
    
    size(A_cube)
end
















