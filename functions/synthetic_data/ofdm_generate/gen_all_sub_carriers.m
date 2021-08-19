function carriers = gen_all_sub_carriers(t, l, Tu, Ts, Tg,N, w, a)
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
    %   > w  - frequency weight
    %   > a  - complex phase value
    %  Outputs
    %   > (N x t) array of complex time domain sinusoid values
    %
    % ---------------------------------------------------------------------
   
   %pre allocating memory
   carriers = zeros(1,length(t));
   
   %carriers around center
   carrier_vals = -N/2 : N/2;
    
   %generating all sub carriers
   %constant summing to save memory
   for n = 1:(N+1)
        
       if a(n) == 0
       %dont waste time generating zeros
        continue
       end
   
       carrier_temp = gen_sub_carrier(t, l, Tu, Ts, Tg, carrier_vals(n) );
       %applying frequency wight
       carrier_temp = carrier_temp*w(n);
       %applying phase weight
       carrier_temp = carrier_temp*a(n);
       %adding to envelope
       carriers = carriers + carrier_temp;
   end

end