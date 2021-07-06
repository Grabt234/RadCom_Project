%=================================
% Key 
%=================================
% n    - Number of bits encoded in a single letter
% bits - The bit stream to be converted to phase codes 
%
% map  - The alphabet mapping
%
% L    - Number of symbols in a frame
% N    - Number of sub carriers in a symbol
% F    - number of frames in a signal (dependant of bitstream size)
%
% f0  - Center frequency 
% T   - Elementary period
%
% N   - Number of sub carriers in signal: excluding center
% N_0 - Number of sub carriers in signal inclding center
% L   - Symbols per frame
% Ts  - Elementary periods per symbol
% Tu  - Elementary periods per integration period
% Tg  - Elementary periods in the gaurd interval
%================================================
%================================================


%% WAVEFORM PARAMETERS
n = 2;
bits = '0100111011010011110110101110110000010101001101011';

f0 = 2.48*10^3;
T = 1/f0;

dab_mode = load_dab_rad_constants(2);


%% EXTRACTING DAB_CONSTANTS

%symbols
L = dab_mode.L;
%carriers no center
K = dab_mode.K ;
%carriers incl. center
K_0 = dab_mode.K + 1;
%integration period
Tu = dab_mode.Tu;
%symbol period
Ts = dab_mode.Ts;
%gaurd inteval
Tg = dab_mode.Tg;
%intra frame time: spacing between pulses within a frame
T_intra = dab_mode.T_intra;

%% ENCODING BITS

[F, A_cube] = bits_to_phase_cube(bits,n,dab_mode);
%frames need to be third dimenson, therefore shift

%Frequency weights ()
W_cube = ones(L,K_0,F);
W_cube = rescale_cube_to_unity_weights(W_cube,F);

%% GENERATING WAVEFORM

%time per symbol
symbol_time = linspace(T,Ts,Ts);

%generating all envelopes of frames
S = gen_all_pulses(symbol_time, F, L, Tu, Ts, Tg, K,W_cube,A_cube);

%interframe time
tif_time = linspace(T,Tif,T_intra);

%adding in interframe time periods
S = insert_inter_frame_time(S, F, tif_time);


%% PLOTTING

%converting rows to columns
S = S';
%stacking all columns the transposing
S = S(:)';

tot_time = linspace(T,F*L*(Ts+T_intra)*T, F*(L*(Ts)+T_intra) );
length(S)
length(tot_time)
plot(tot_time, S)























