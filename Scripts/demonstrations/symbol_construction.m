%===========================================================
% Demonstrates (visually) how an ofdm symbol is constructed 
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
% F   - Number of frames (dependant of bits)
%===========================================================
%%

%===========================================================
% Configurations
%===========================================================

f0 = 2.048*10^6;
T = 1/f0;

a = 12;
b = 10;
d = 5;

N = 6;
N_0 = N+1; 
L = 5;
Ts  = a*T;
Tu  = b*T;
Tg  = (a-b)*T;

osf = 20;

%% EXAMPLE: GENERATE SUB CARRIERS
t = linspace(T,a*T,a*osf)-T;

N1  = gen_sub_carrier(t, 1, Tu, Ts, Tg, N );
% N10 = gen_all_sub_carriers(t, 2, Tu, Ts, Tg,10);
% N100= gen_all_sub_carriers(t, 2, Tu, Ts, Tg,20);

%uncomment for plots

plot(t,N1);
title("Plot showing 1 sub carriers: a = 12, b = 10, T = 4.88e-7");
ylabel("Amplitude")
xlabel("Time in seconds")
% figure
% plot(t,N10);
% title("Plot showing 10 sub carriers");
% xlabel("Time in seconds")
% ylabel("Amplitude")
% figure
% plot(t,N100);
% title("Plot showing 20 sub carriers");
% ylabel("Amplitude")
% xlabel("Time in seconds")


%% EXAMPLE: APPLY PHASE CODES

N4_0  = gen_all_sub_carriers(t, 2, Tu, Ts, Tg,4);

%creating phase codes (L=1, N=4)
a = gen_rand_phase_weights(1,4+1);
%applying phase weights
N4_a = apply_phase_weights(N4_0,a.');

% plot(t, N4_0(1:2,:));
% title("2 Sinusoids with no phase coding applied");
% ylabel("Amplitude");
% xlabel("Time in seconds");
% figure
% plot(t,N4_a(1:2,:));
% title("2 Sinusoid with random phase coding applied");
% ylabel("Amplitude");
% xlabel("Time in seconds");

%% EXAMPLE: APPLY FREQUENCY WEIGHTS

N4_1  = gen_all_sub_carriers(t, 2, Tu, Ts, Tg,4);

%creating phase codes (L=1, N=4)
a = gen_rand_freq_weights(1,4+1);
%applying phase weights
N4_w = apply_freq_weights(N4_1,a.');

% plot(t, N4_1(1:2,:));
% title("2 Sinusoids with no frequency weights applied");
% ylabel("Amplitude");
% xlabel("Time in seconds");
% figure
% plot(t,N4_w(1:2,:));
% title("2 Sinusoid with random frequency weights applied");
% ylabel("Amplitude");
% xlabel("Time in seconds");
%% EXAMPLE: SUM SYMBOLS INTO ENVELOPE

N15  = gen_all_sub_carriers(t, 2, Tu, Ts, Tg, 14);

%creating phase codes (L=1, N=14/5)zeros(1, 15*length(s_rows(2,:)))
a = gen_rand_phase_weights(1,14+1);
%applying phase weights
N15_a = apply_phase_weights(N15,a.');


N15_env = sum(N15_a);

% plot(t,N15_a)
% title("15 Sinusoids with random phase codes applied");
% ylabel("Amplitude");
% xlabel("Time in seconds");
% figure
% plot(t,N15_env);
% title("15 Sinusoids with random phase codes applied summed into a single complex envelope");
% ylabel("Amplitude");
% xlabel("Time in seconds");
%%






























































