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
%bits = '0000000000000000000000000000000000000000';
%bits =  '1111111111111111111111111111111111111111'
%bits =  '1010101010101010101010101010101010101010'
% bits =  '110110100110110110111111110001';
bits = '111111111111111111111111111111111111111111111111111111111111111111111111111111';
        

f0 = 2.048*10^6;
T = 1/f0;

dab_mode = load_dab_rad_constants(2);


%% EXTRACTING DAB_CONSTANTS

%symbols
L = dab_mode.L;
L_0 = L + 1;
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
% 
[F, A_pulses] = bits_to_phase_cube(bits,n,dab_mode);

%Frequency weights ()
W_cube = ones(L_0,K_0,F);
W_cube = rescale_cube_to_unity_weights(W_cube,F);

%% GENERATING WAVEFORM

%time per symbol
symbol_time = linspace(T,Ts,Ts);

%generating all envelopes of frames
S = gen_all_pulses(symbol_time, F, L_0, Tu, Ts, Tg, K,W_cube,A_pulses);

%interframe time
tif_time = linspace(T,T_intra,T_intra);

%adding in interframe time periods
S = insert_inter_frame_time(S, F, tif_time);


%% PLOTTING
    
%converting rows to columns
S = S';
%stacking all columns the transposing
S = S(:)';

figure
plot(1:1:length(S), S)

%% WRITTING TO FILES
% 
create_hdf5('synthetic_encoded_data',S);

%%

%ns
% figure
% ns = S(1:dab_mode.Tnull);
% plot(1:1:length(ns),ns)

%prs

prs = S( dab_mode.Tnull + dab_mode.Tg + 1: dab_mode.Tnull + dab_mode.Tg + 1 +dab_mode.Tu-1);
% plot(1:1:length(prs),prs)

%symbol
% figure
% ss = S(1+dab_mode.Tnull+dab_mode.Ts:dab_mode.Tnull+2*dab_mode.Ts);
% plot(1:1:length(ss),ss)

%Tu symbol
% figure
sss = S(dab_mode.Tnull + dab_mode.Tg + 1 + dab_mode.Ts:dab_mode.Ts+ dab_mode.Tnull + dab_mode.Tg + 1 +dab_mode.Tu-1);
length(prs)

%  plot(1:1:length(prs), abs(imag(prs)))
% 
PRS = fftshift(fft(prs));
SSS = fftshift(fft(sss));

% figure
% plot(1:1:length(SSS),abs(SSS))
% 
% figure
% plot(1:1:length(PRS),abs(PRS))

a = SSS./PRS;
% a = PRS;
% 
% length(prs)
rad2deg(angle(a(dab_mode.mask)))


% a = a(dab_mode.mask);
% 
% wrapTo360(rad2deg(angle(a)))





















