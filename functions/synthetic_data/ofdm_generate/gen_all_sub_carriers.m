function carriers = gen_all_sub_carriers(t, l, Tu, Ts, Tg,N)
    % ---------------------------------------------------------------------    
    % gen_sub_carrier: generates an array of complex time domain
    %                    sinusoid values according to dab params (incl CRC)
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > t  - Array of time values for which to calculate the sinusoid
    %   > l  - OFDM symbols symbol number (per frame)
    %   > Tu - Useful time period(not inlcuding crc)
    %   > Tg - Guard Inverval
    %   > Ts - Symbol time period (Ts + Tg)
    %   > N  - Totol number of sub carriers in signal
    %  Outputs
    %   > (N x t) array of complex time domain sinusoid values
    %
    % ---------------------------------------------------------------------
   
   %pre allocating memory
   carriers = zeros(N+1,length(t));
   
   %carriers around center
   carrier_vals = -N/2 : N/2;
    
   %generating all sub carriers
   for n = 1:numel( carrier_vals )

       carriers(n,:) = gen_sub_carrier(t, l, Tu, Ts, Tg, carrier_vals(n) );
       
   end

end