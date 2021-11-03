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
    carriers = zeros(N,length(t));
    
    %carriers around center
    carrier_vals = -N/2 : N/2;
    
    %generating all sub carriers
    %constant summing to save memory

    for n = 1:(N+1)
        
       if a(n) == 0
        
           carriers(n,:) = 0;
            continue
       end
        
       carriers(n,:) = gen_sub_carrier(t, l, Tu, Ts, Tg, carrier_vals(n) );
       %applying frequency wight
       carriers(n,:) = carriers(n,:)*w(n);
       %applying phase weight
       carriers(n,:) = carriers(n,:)*a(n);

    end
    
    %compressing rows into single row - form cmplx envelope
    carriers = sum(carriers);
    
    plot(1:1:2048,abs(fftshift(fft(carriers))))
    
end






























