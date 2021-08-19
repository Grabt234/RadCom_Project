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
    remainder = mod( length(bits), n)
    rows = (length(bits) - remainder)/n + ceil(remainder/n)
    
    %preallocating array of strings
    B = zeros(rows,1);
    B = strings(size(B));
    
    for i = 1:rows-1
        
        B(i,1) = bits(1:n);
        bits(1:n) = [];
        
    end
    
    %for final row, if not enough bits to fill, pad it
    %string in sprintf taking form '%0ns' where n changes
    B(rows,1) = sprintf('%0'+string(n)+'s',bits);

end