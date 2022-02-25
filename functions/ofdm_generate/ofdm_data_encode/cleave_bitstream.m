function B = cleave_bitstream(bits, n)
    % ---------------------------------------------------------------------    
    % cleave_bitstream: Cuts bitstream and converts to "n" long binary 
    %                       strings into an array 
    %                                             
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > alphabet_map - continous bit stream to be transmitted a single row
    %  > n            - number of bits in a single letter
    %  Outputs
    %  > B - array of bits 
    %
    % ---------------------------------------------------------------------
    
    if( isempty(bits) )
        %in the case where only prs is beiing generated
        B = ones(0,0);
        return
    end
    
    %preallocating array to fit grouped letters
    remainder = mod( length(bits), n);
    
    %if need to pad with 0's
    if remainder ~= 0
        
        fill = strjoin(string(ones(1,remainder)));
    
        %round to number of carriers by filling with zeros
        bits = strjoin([bits fill]);
    
    end
   
    %cutting into encoding pieces
    B = (reshape(bits, n, [])');
  
end