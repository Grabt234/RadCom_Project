function X_norm = normalize_matrix(X)
    % ---------------------------------------------------------------------    
    % normalize_matrix: Normalises entire matrix
    %                                             
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > X - matrix to be normalised
    %  Outputs 
    %  > X_norm - normalised matrix     
    %
    % ---------------------------------------------------------------------
    
    
    X_norm = X - min(X(:));
    X_norm = X_norm ./ max(X_norm(:));

    
end