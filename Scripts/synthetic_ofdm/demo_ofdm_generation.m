%=================================
% Key 
%=================================
% f0  - Center frequency 
% T   - Elementary period
%
% N   - Number of sub carriers in signal: excluding center
% N_0 - Number of sub carriers in signal inclding center
% L   - Symbols per frame
% Ts  - Elementary periods per symbol
% Tu  - Elementary periods per integration period
% Tg  - Elementary periods in the gaurd interval
%
% a   - Number elementary periods in symbol period
% b   - Number elementary periods in integration period
% d   - Number elementary periods in interframe period
%
% F   - Number of frames (dependant of bits)
%================================================
%================================================


%================================================
% Definitions
%================================================
f0 = 2.048*10^6;
T = 1/f0;

a = 25;
b = 18;
d = 5;

N = 500;
N_0 = N+1; % including 0th subcarrier
L = 5;
Ts  = a*T;
Tu  = b*T;
Tg  = (a-b)*T;

F = 1;
Tif = d*T; %assinged inter-frame time period to be same as frame period 

t_sig = F*(L*(a)+d); %in emelentary periods
osf = 10; %over_sample_factor
%================================================
%================================================



%================================================
% Configurations
%================================================
%frequency weights (N x L x F)

W_cube = ones(L,N_0,F);
%W_cube = gen_rand_freq_weights_cube(L,N_0,F);
W_cube = rescale_cube_to_unity_weights(W_cube,F);

%taking transpose to turn into vector
A_cube = gen_rand_frame_phase_weights_cube(L,N_0,F);
%================================================
%================================================



%================================================
% Generation
%================================================
%time per symbol
symbol_time = linspace(T,Ts,a*osf);

%generating all envelopes of frames
S = gen_all_frames(symbol_time, F, L, Tu, Ts, Tg, N,W_cube,A_cube);

%interframe time
tif_time = linspace(T,Tif,d*osf);

%adding in interframe time periods
S = insert_intra_frame_time(S, F, tif_time);

%converting rows to columns
S = S';
%stacking all columns the transposing
S = S(:)';


%================================================
%================================================

tot_time = linspace(T,t_sig*T, t_sig*osf );
S_0 = gen_center_frequency(T,tot_time);

S = S_0.*S;

plot(tot_time, S)





