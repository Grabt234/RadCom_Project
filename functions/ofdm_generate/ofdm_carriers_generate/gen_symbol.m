function s = gen_symbol(t, Tu, Tg, K, w, a)
    % ---------------------------------------------------------------------    
    % gen_symbol: encapsulation of gen_all_sub_carriers for readability
    %                                    
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > t  - Array of elemtary units (1:Ts) to generate  sinusoid
    %           length of symbol time length(t) = Ts = Tg + Tu
    %   > Tu - Integration period
    %   > Tg - Guard Inverval
    %   > K  - OFDM carriers per symbol ()
    %   > w  - frequency weight vector (1xK)
    %   > a  - complex phase value (1xK)
    %  Outputs
    %   > (1 x Ts) array of complex time domain sinusoid values
    %
    % ---------------------------------------------------------------------
   
  
   s = gen_all_sub_carriers(t, Tu, Tg, K, w, a);
    
end