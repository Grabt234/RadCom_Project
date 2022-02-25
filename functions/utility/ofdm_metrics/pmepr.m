function PMEPR = pmepr(S)
    % ---------------------------------------------------------------------    
    % pmepr: calculates the peak to mean envelope power ratio
    %                                             
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > S - array of complex signal envelope 
    %  Outputs 
    %  > pmepr - peak to mean envelope power ratio     
    %
    % ---------------------------------------------------------------------
    
    %Finding abs(S_max)
    peak = max(S);
    peak = peak*conj(peak);
    
    %finding Power in signal
    P = S.*conj(S);
    
    PMEPR = peak/mean(P);
    
end