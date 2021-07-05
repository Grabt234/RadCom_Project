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
bits = '01011010001001101010111111000101110010010101011110111110101011000';

dab_mode = load_dab_rad_constants(2);

%N_0 with off carrier will = 4
%================================================
%================================================

%% CLEAVING BIT STREAM
map = define_alphabet_map(n);

%breaking bitstream into n sized strings
cleaved_bit_stream = cleave_bitstream(bits,n);

%% BIT STREAM TO PHASE CODE

%encoding strings in phases
A = bitstream_to_phase(map,cleaved_bit_stream);

%convverting phases to unity magnitude complex numebers
A = convert_phase_to_complex(A);

%% PHASE CODES TO SYMBOLS

%converting phase codes to set of symbols
L_encode = convert_vector_symbols(A,dab_mode);

%% SYMBOLS TO FRAME

%adding in prs
L_encode = add_prs_A_cube(L_encode, dab_mode);

%converting to phase cube
A_cubes = symbols_to_A_cubes(L_encode,dab_mode);

%% UNSUSED

% %coverting phases to differential encoding
% A_cube = convert_phase_cube_dpsk(A_cube);
% 
% %inserting off carrier
% A_cube = insert_central_carrier(A_cube,L,N,F);
%=========================================== =====
%================================================


%================================================
% Note
%================================================
% This set of functions is encapsulated in the 
% function " bits_to_phase_cube(bits,n) "
%================================================
%================================================

















