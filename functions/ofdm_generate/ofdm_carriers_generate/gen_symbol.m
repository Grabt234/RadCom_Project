function s = gen_symbol(Ts, Tu, Tg, K, w, a)
    % ---------------------------------------------------------------------    
    % gen_symbol: encapsulation of gen_all_sub_carriers for readability
    %                                    
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > Ts - sSymbol Period
    %   > Tu - Integration period
    %   > Tg - Guard Inverval
    %   > K  - OFDM carriers per symbol ()
    %   > w  - Frequency weight vector (1xK)
    %   > a  - Complex phase value (1xK)
    %  Outputs
    %   > (1 x Ts) Array of complex time domain sinusoid values
    %
    % ---------------------------------------------------------------------
   
    %generating all sub carriers within single symbol
    s = gen_all_sub_carriers(Ts, Tu, Tg, K, w, a);
    
end