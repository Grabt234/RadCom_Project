function carriers = gen_all_sub_carriers(t, Tu, Tg, K, w, a)
    % ---------------------------------------------------------------------    
    % gen_sub_carrier: generates an array of complex time domain
    %                    sinusoid values according to dab params (incl CRC)
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
    %   > (N x t) array of complex time domain sinusoid values
    %
    % ---------------------------------------------------------------------
   
    %pre allocating memory
    carriers = zeros(K,length(t));
    
    %carriers around center
    carrier_index = -K/2 : K/2;
    
    %generating K sub carriers
    for k = 1:(K+1)
        
       if a(k) == 0
            
           %central null carrier as per DAB standard
           carriers(k,:) = 0;
           continue
            
       end
       
       %generating symbol sub carrier
       carriers(k,:) = gen_sub_carrier(t, Tu, Tg, carrier_index(k));
       
       %applying frequency wight
       carriers(k,:) = carriers(k,:)*w(k);
       
       %applying phase weight
       carriers(k,:) = carriers(k,:)*a(k);

    end
    
    %compressing rows into single row - form cmplx envelope
    carriers = sum(carriers);
    
end






























