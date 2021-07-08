 function L_encode = convert_symbols_dpsk(L_encode)
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
   
    %running through all rows wihtout altering prs
    for i = 2:size(L_encode,1)
    
        %applying dpsk z(i) = z(i-1)*y(i)
        L_encode(i,:,:) = L_encode(i,:).*L_encode(i-1,:); 
        
    end
end