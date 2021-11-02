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

a = 50;
b = 10;
d = 0;

N = 6;
N_0 = N+1; 
L = 4;
Ts  = a*T;
Tu  = b*T;
Tg  = (a-b)*T;
Tif = d*T

F_intra = 1;

osf = 20;

%% EXAMPLE: GENERATING SYMBOLS
symbol_time = linspace(T,Ts,a*osf)-T;

W_cube = ones(L,N_0,F_intra);

%A_cube = ones(L,N_0,F_intra);
A_cube = gen_rand_frame_phase_weights_cube(L,N_0,F_intra);

size(A_cube(1,:,:,1))

[s,s_rows] = gen_all_symbols(symbol_time,L , Tu , Ts ,Tg, N,W_cube,A_cube);

size(s_rows)

time = linspace(1,length(s),length(s))*T-T;

plot(time, s);
title("Plot of a 4 symbols with 6 carriers and null symbol")
ylabel("Amplitude");
xlabel("Time in seconds");

%% FFT'ING PULSE

s_rows_fft = [s_rows(2,:) 4*zeros(1, 15*length(s_rows(2,:)))];
s_rows_fft =  abs(fftshift(fft(s_rows_fft,[],2),2));
s_rows_fft = s_rows_fft/length(s_rows);
% 
figure
plot(linspace(1,length(s_rows_fft),length(s_rows_fft)),(s_rows_fft))
title("Example of fft of signal with N = 6") 
% 












































