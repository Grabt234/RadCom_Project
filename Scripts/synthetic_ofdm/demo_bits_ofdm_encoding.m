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


%================================================
% Definitions
%================================================
n = 2;
bits = '011011100001111001100';

f0 = 0.05*10^6;
T = 1/f0;

dab_mode = load_dab_rad_constants(2);
%================================================
%================================================



%================================================
% Configurations
%================================================

[F, A_cube] = bits_to_phase_cube(bits,n,dab_mode);
size(A_cube)
%Frequency weights ()
% W_cube = ones(L,N_0,F);
% W_cube = rescale_cube_to_unity_weights(W_cube,F);
% 
% %================================================
% %================================================
% 
% 
% 
% %================================================
% % Generation
% %================================================
% %time per symbol
% symbol_time = linspace(T,Ts,a);
% 
% %generating all envelopes of frames
% S = gen_all_pulses(symbol_time, F, L, Tu, Ts, Tg, N,W_cube,A_cube);
% 
% %interframe time
% tif_time = linspace(T,Tif,d);
% 
% %adding in interframe time periods
% S = insert_inter_frame_time(S, F, tif_time);
% 
% %================================================
% %================================================
% 
% 
% %converting rows to columns
% S = S';
% %stacking all columns the transposing
% S = S(:)';
% 
% tot_time = linspace(T,F*L*(a+d)*T, F*(L*(a)+d) );
% length(S)
% length(tot_time)
% plot(tot_time, S)























