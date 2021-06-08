function ISLR = islr(S)
    % ---------------------------------------------------------------------    
    % islr: calculates integrated sidelobe ratio of complex envelope
    %                                             
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > S - array of complex signal envelope 
    %  Outputs 
    %  > pslr - pslr as a number     
    %
    % ---------------------------------------------------------------------
    
    %calculating autocorellation
    R = xcorr(S);
    
    %finding peak correlation
    peak = max(R);
    
    %integrated sidelob: summing and subtracting peak
    summed = sum(R)-peak;
    
    %calculating islr
    ISLR = summed/peak;
    
end