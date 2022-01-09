%================================================
% Note that this file is dabMode independant
% Tests generation of ofdm signal 
%phase code agnostic
%================================================

%% WAVEFORM PARAMETERS

f0 = 2.048e6;
T = 1/f0;

%% EXTRACTING DAB_CONSTANTS

%Number of frames
F = 1;
%symbols
L = 1;
L_0 = L;
%carriers no center
K = 1000;    
%carriers incl. center
K_0 = K + 1;
%integration period
Tu = 2048;
%gaurd inteval
Tg = 504;
%symbol period
Ts = 2048;
%intra frame time: spacing between pulses within a frame
T_intra = 0;

%% Phase And Frequency Weights

A_cube = ones(F,L_0, K_0);

%Frequency weights 
W_cube = ones(F,L_0,K_0);
W_cube = rescale_cube_to_unity_weights(W_cube,F);

%% GENERATING WAVEFORM

symbol_time = 1:1:Ts;

%generating all envelopes of frames
    %note this is a F x(L*Ts) array
S = gen_all_pulses(symbol_time, F, L_0, Tu, Ts, Tg, K,W_cube,A_cube);

%% Plotting

plot(1:1:length(S), abs(S))

%% WRITTING TO FILES


