function s = gen_sub_carrier(t, Tu, Tg,k)
    % ---------------------------------------------------------------------    
    % gen_sub_carrier: generates an array of complex time domain
    %                    sinusoid values according to dab params (incl.CRC)
    %                       with no phase and weight modulation
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > t  - Array of elemtary units (1:length(t)) to generate  sinusoid
    %   > k  - OFDM symbols symbol number (per frame)
    %   > Tu - Integration period
    %   > Tg - Guard Inverval
    %  Outputs
    %  > (1 x length(t)) array of complex time domain sinusoid values
    %
    % ---------------------------------------------------------------------
    
      %exp generates as a complex value
      s = exp((2*1i*pi*(k)*(t-Tg))/(Tu));
      
end