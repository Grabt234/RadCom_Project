%=================================
% Key 
%=================================
% n    - Number of bits encoded in a single letter
% bits - The bit stream to be converted to phase codes 
%
% L    - Number of symbols in a frame
% N    - Number of sub carriers in a symbol
%
% map  - The alphabet mapping
%================================================
%================================================


%================================================
% Definitions
%================================================
n = 2;
bits = '0101101000101';

L = 4;
N = 4; %must be equal
%N_0 with off carrier will = 4
%================================================
%================================================


%================================================
% Configurations
%================================================
map = define_alphabet_map(n);

%breaking bitstream into n sized strings
B = cleave_bitstream(bits,n);

%encoding strings in phases
A = bitstream_to_phase(map,B);

%convverting phases to unity magnitude complex numebers
A = convert_phase_to_complex(A);

%returns F frames, dependant on size of input data
%reshaping data into cube
[F,A_cube] = convert_vector_to_cube(A,L,N);

%coverting phases to differential encoding
A_cube = convert_phase_cube_dpsk(A_cube);

%inserting off carrier
A_cube = insert_central_carrier(A_cube,L,N,F);
%================================================
%================================================


%================================================
% Note
%================================================
% This set of functions is encapsulated in the 
% function " bits_to_phase_cube(bits,n) "
%================================================
%================================================

















