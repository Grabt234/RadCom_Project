function s = gen_symbol(t, l , Tu , Ts ,Tg, N, w, a)
    % ---------------------------------------------------------------------    
    % gen_symbol: Applies freq and phase weights to subcarriers to create a
    %                   the symbol
    %                                    
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > t  - Array of time values for which to calculate the sinusoid
    %   > l  - OFDM symbol number (within the broader frame) 
    %   > Tu - Useful time period(not inlcuding crc)
    %   > Tg - Guard Inverval
    %   > Ts - Symbol time period (Ts + Tg)
    %   > N  - Total number of sub carriers in signal
    %   > w  - Column vector of frequency weights
    %   > a  - Column vector of phase codes
    %  Outputs
    %   > s = Complex envelope corresponding to the symbol points within
    %           the time domain
    %
    % ---------------------------------------------------------------------
   
  
   s = gen_all_sub_carriers(t,l , Tu , Ts ,Tg, N, w, a);
    
end