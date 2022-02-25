function s = gen_sub_carrier(Ts, Tu, Tg,k)
    % ---------------------------------------------------------------------    
    % gen_sub_carrier: generates an array of complex time domain
    %                    sinusoid values according to dab params (incl.CRC)
    %                       with no phase and weight modulation
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > Ts - Symbol period   [in elementary units]
    %   > Tu - Integration period [in elementary units]
    %   > Tg - Guard Inverval [in elementary units]
    %   > k  - OFDM carrier index
    %  Outputs
    %  > (1 x Ts) Array of complex time domain sinusoid values
    %
    % ---------------------------------------------------------------------
    
      %exp generates as a complex value
      s = exp((2*1i*pi*(k)*((1:Ts)-Tg))/(Tu));
      
end