%================================================
% Note that this file is dabMode independant
% Tests generation of ofdm signal 
%phase code agnostic
%================================================

clear all 
close all

%% WAVEFORM PARAMETERS

f0 = 2.048e6;
T = 1/f0;

%% Setting Test Parameters

Ls = [2 5 8 10];
Ks = [1000 1000 1000 1000];

for i = 1: length(Ls)
    
    %Number of frames
    F = 1;
    %symbols
    L = Ls(i);
    L_0 = L;
    %carriers no center
    K = Ks(i);    
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
    s = gen_all_frames(symbol_time, F, L_0, Tu, Ts, Tg, K,W_cube,A_cube);

    %% Plotting
    
    %first reshaping
    s = reshape(s,2048,[]);
    s = s';
    
    S = fftshift(fft(s,[],2),2);

    %normalising
    S = S./max(S,[],"all");
    
    subplot(2,2,i)
    h = surf((((1:1:length(S)) - length(S)/2))*(f0/1000), 1:1:Ls(i), 20*log10(abs(S)));
    colour = [0, 0.4470, 0.7410];
    colormap 'white';
    h.FaceLighting = 'flat';
    h.EdgeAlpha = 1;
    h.EdgeColor = colour;
    h.EdgeLighting = 'gouraud';
    xlim tight
    ylim tight
    zlim padded
    xlabel("Frequency [Mhz]", "FontSize", 15)
    ylabel("Symbol Number [l]", "FontSize", 15)

end


