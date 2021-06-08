function [F,A_cube] = bits_to_phase_cube(bits, n, L, N)
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
   
    map = define_alphabet_map(n);

    %breaking bitstream into n sized strings
    B = cleave_bitstream(bits,n);

    %encoding strings in phases
    A = bitstream_to_phase(map,B);

    %converting phases to unity magnitude complex numebers
    A = convert_phase_to_complex(A);

    %returns F frames, dependant on size of input data
    %reshaping data into cube
    [F,A_cube] = convert_vector_to_cube(A,L,N);
    
    %coverting phases to differential encoding
    A_cube = convert_phase_cube_dpsk(A_cube);
    
    %now adding in central "off" carrier
    A_cube = insert_central_carrier(A_cube, L, N, F);
   
end