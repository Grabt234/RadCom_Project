function g = gen_sub_carrier(t, l, Tu, Ts, Tg,k)
    % ---------------------------------------------------------------------    
    % gen_sub_carrier: generates an array of complex time domain
    %                    sinusoid values according to dab params (incl.CRC)
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > t  - array of time values for which to calculate the sinusoid
    %   > l  - OFDM symbols symbol number (per frane)
    %   > Tu - Useful time period(not inlcuding crc)
    %   > Tg - Guard Inverval
    %   > Ts - Symbol time period (Ts + Tg)
    %   > n  - Subcarrier number
    %  Outputs
    %  > (1 x t) array of complex time domain sinusoid values
    %
    % ---------------------------------------------------------------------
      
    % -Tg is the addition of the guard interval
    
      %exp generates as a complex value
      g = exp((2*1i*pi*(k)*(t-Tg))/(Tu));
      
end