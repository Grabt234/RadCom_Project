function a = convert_phase_to_bin(alphabet_map, phase)
    % ---------------------------------------------------------------------    
    % convert_bin_to_phase: uses a map to convert a binary number to a
    %                           a phase which can be encoded on a wave
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > alphabet_map - The map used to translate between binary and
    %                       phases
    %  > bin          - Binary *string* to be encoded into a phase
    %  Outputs
    %  > a       - binary encoded phase
    %
    % ---------------------------------------------------------------------
   
    a = alphabet_map(bin);

end