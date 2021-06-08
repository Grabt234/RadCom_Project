function PSLR = pslr(S)
    % ---------------------------------------------------------------------    
    % pslr: calculates peak sidelobe ratio of complex envelope
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
    
    %finding peaks correlation
    peaks = findpeaks(R);
    
    %sorting peaks into decending order
    peaks = sort(peaks,'descend');
    
    %calculating pslr
    PSLR = peaks(2)/peaks(1);
    
end