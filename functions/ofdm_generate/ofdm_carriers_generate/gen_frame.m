function s = gen_frame(Ts, Tu, Tg, W, A, L)
    % ---------------------------------------------------------------------    
    % gen_frame: encapsulation of gen_all_symbols for readability
    %                                  
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > Ts - Symbol Period
    %   > Tu - Integration period
    %   > Tg - Guard Inverval
    %   > K  - OFDM carriers per symbol 
    %   > W  - frequency weight matrix (LxK)
    %   > A  - complex phase matrix (LxK)
    %  Outputs
    %   > s = iq data of frame, array of size (1xL*Ts)
    %
    % ---------------------------------------------------------------------
    
    %all symbols into a single continous frame
    [s,~]= gen_all_symbols(Ts , Tu ,Tg, W, A, L);
    

end