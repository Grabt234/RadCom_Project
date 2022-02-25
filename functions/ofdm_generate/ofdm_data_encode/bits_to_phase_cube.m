function [F,A_pulses] = bits_to_phase_cube(bits, n, dab_mode)
    % ---------------------------------------------------------------------    
    % bits_to_phase_cube: uses a map generated with an alphabet size of 2^n
    %                       to convert a binary number to a phase cube 
    %                       which can be encoded on a wave
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > bits - The bitstream to be encoded
    %  > n    - 2^n alphabet size
    %  > L    - number of symbols in a frame
    %  > N    - number of subcarriers in a symbol
    %
    %  Outputs
    %  > F      - The number of frames required to transmit a bitstream
    %  > A_cube - The phase encoding cube to be applied to the frames 
    %               ( (L x N) x F)
    %
    % ---------------------------------------------------------------------
   
    %% CLEAVING BIT STREAM
    map = define_alphabet_map(n);

    %breaking bitstream into n sized strings
    cleaved_bit_stream = cleave_bitstream(bits,n);
    
    %% BIT STREAM TO PHASE CODE

    %encoding strings in phases
    A = bitstream_to_phase(map,cleaved_bit_stream);

    %converting phases to unity magnitude complex numebers
    A = convert_phase_to_complex(A);
    
    %% PHASE CODES TO SYMBOLS

    %converting phase codes to set of symbols
    L_encode = convert_vector_symbols(A,dab_mode.K);
    
    %% SYMBOLS TO FRAME
    
    %adding in prs
    L_encode = prepend_prs(L_encode, dab_mode);
 
    %filling in to round pulse numbers
    L_encode = fill_symbols(L_encode, dab_mode);
   
    %coverting phases to differential encoding
    L_dpsk = convert_symbols_dpsk(L_encode);
    
    %converting to phase codes for each PULSE (multiple in frame)
    A_pulses = symbols_to_A_pulses(L_dpsk,dab_mode);    

    %% QPSK, CENTRAL CARRIER AND NULL

    %each pulse must begin with a null symbol
    A_pulses = add_null(A_pulses);

    %inserting CENTRAL off carrier 
    A_pulses = insert_central_carrier(A_pulses,dab_mode);

    %number of PULSES required to be transmitted
    F = size(A_pulses,1);
   
end










