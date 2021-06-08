%===========================================================
% Demonstrates (visually) how an ofdm pulse is constructed 
%===========================================================
%                           Key 
%===========================================================
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
% >F_intra -  number of intra frame pulses
%===========================================================
%%

%===========================================================
% Configurations
%===========================================================

f0 = 2.048*10^6;
T = 1/f0;

a = 20;
b = 14;
d = 0;

N = 120;
N_0 = N+1; 
L = 3;
Ts  = a*T;
Tu  = b*T;
Tg  = (a-b)*T;
Tif = d*T;

F_intra = 1;

t_sig = F_intra*(L*(a)+d);

osf = 50;

%% EXAMPLE: GENERATING SYMBOLS
symbol_time = linspace(T,Ts,a*osf)-T;

W_cube = ones(L,N_0,F_intra);

%A_cube = ones(L,N_0,F_intra);
A_cube = gen_rand_frame_phase_weights_cube(L,N_0,F_intra);
A_cube = rescale_cube_to_unity_weights(A_cube,F_intra);


s = gen_all_pulses(symbol_time,F_intra,L , Tu , Ts ,Tg, N,W_cube,A_cube);

s = insert_intra_frame_time(s,F_intra,symbol_time);

s = s';
s = s(:)';


tot_time = linspace(T,length(s)*T, length(s) );
S_0 = gen_center_frequency(T,tot_time);

length(S_0)
length(s)

S = S_0.*s;

sig_length = length(S);
ambiguity_function_V4_2(s,T,f0,sig_length,1,50,L,Ts)










































