function A = bitstream_to_phase(alphabet_map, B)
    % ---------------------------------------------------------------------    
    % bitstream_to_phase: converts the column bit groups to 
    %                           phase equivalents 
    %                                             
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > alphabet_map - continous bit stream to be transmitted a single row
    %  > B            - column of bit groups
    %  Outputs
    %  > A - column of translated phases 
    %
    % ---------------------------------------------------------------------
    
    %preallocating memory
    A = zeros(size(B));
    
    for b = 1:length(B)
        
        A(b) = convert_bin_to_phase(alphabet_map,B(b));
        
    end
    
end