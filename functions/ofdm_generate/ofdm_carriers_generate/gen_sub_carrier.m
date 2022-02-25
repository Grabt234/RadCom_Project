function s = gen_sub_carrier(t, Tu, Tg,k)
    % ---------------------------------------------------------------------    
    % gen_sub_carrier: generates an array of complex time domain
    %                    sinusoid values according to dab params (incl.CRC)
    %                       with no phase and weight modulation
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > t  - Array of elemtary units (1:Ts) to generate  sinusoid
    %           length of symbol time length(t) = Ts = Tg + Tu
    %   > Tu - Integration period
    %   > Tg - Guard Inverval
    %   > k  - OFDM carrier index
    %  Outputs
    %  > (1 x Ts) array of complex time domain sinusoid values
    %
    % ---------------------------------------------------------------------
    
      %exp generates as a complex value
      s = exp((2*1i*pi*(k)*(t-Tg))/(Tu));
      
end