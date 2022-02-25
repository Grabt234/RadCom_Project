function carriers = gen_all_sub_carriers(Ts, Tu, Tg, K, w, a)
    % ---------------------------------------------------------------------    
    % gen_all_sub_carrier: generates an array of complex time domain
    %                       values containing all sub carriers within
    %                       single symbol
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > Ts - symbol period
    %   > Tu - Integration period
    %   > Tg - Guard Inverval
    %   > K  - OFDM carriers per symbol ()
    %   > w  - Frequency weight vector (1xK)
    %   > a  - Complex phase value (1xK)
    %  Outputs
    %   > (1 x Ts) Array of complex time domain sinusoid values
    %
    % ---------------------------------------------------------------------
   
    %pre allocating memory
    carriers = zeros(K,Ts);
    
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
       carriers(k,:) = gen_sub_carrier(Ts, Tu, Tg, carrier_index(k));
       
       %applying frequency wight
       carriers(k,:) = carriers(k,:)*w(k);
       
       %applying phase weight
       carriers(k,:) = carriers(k,:)*a(k);

    end
    
    %compressing rows into single row - form cmplx envelope
    carriers = sum(carriers);
    
end






























