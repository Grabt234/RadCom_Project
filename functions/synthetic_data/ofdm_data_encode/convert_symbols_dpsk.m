 function L_dqpsk = convert_symbols_dpsk(L_encode)
    % ---------------------------------------------------------------------    
    % convert_symbols_dpsk: Takes a phase cube and alters it to form a 
    %                           differential phase cube where original
    %                           phases are encoded in the difference
    %                           between previous and current symbol. z =
    %                           z(n-1)*y
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > L_encode - (n x (Lxk)) symbols that will be transmitted
    %            
    %  Outputs
    %  > L_encode - dpsk symbols
    %
    % ---------------------------------------------------------------------
    
    %creating zeros size of L_encode
    L_dqpsk = zeros(size(L_encode,1),size(L_encode,2));
    
    %assigning prs
    L_dqpsk(1,:) = L_encode(1,:);
    
    %running through all rows wihtout altering prs
    %note: PRS in first position already
    for i = 2:size(L_encode,1)
        
        fprintf("HHHHHHHHHHHH\n")
        %applying dpsk z(i) => theta_n = theta_(n-1) + phi_n
        
        phase_codes = round(wrapTo360(rad2deg(angle(L_encode(i,:)))));
        
        
        rx_bits = '';

        mapper = define_inverse_alphabet_map(2);

        for z = 1:numel(phase_codes)

           rx_bits = [rx_bits  mapper(phase_codes(z))];

        end
        
        rx_bits
        
        fprintf("JJJ\n")
        L_dqpsk(i,:) = L_encode(i,:).*L_dqpsk(i-1,:);
        fprintf("HHHHHHHHHHH")
        
    end
    
end