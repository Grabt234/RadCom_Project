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

f0 = 200*10^6;
T = 1/f0;

dab_mode = load_dab_rad_constants(2);

a = dab_mode.Tu+dab_mode.Tg;
b = dab_mode.Tu;
d = dab_mode.T_intra;

N = dab_mode.K;
N_0 = N+1; 
L = dab_mode.L;
Ts  = a*T;
Tu  = b*T;
Tg  = (a-b)*T;
Tif = d*T;

F_intra = dab_mode.F_intra;

t_sig = F_intra*(L*(a)+d);

osf = 1;

t_sig = F_intra*(L*(a)+d);

signal_parameters(N,L, T,a,b,1,1)










































