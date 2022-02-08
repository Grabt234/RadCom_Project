%================================================
% Given a sequence with arbitrary number of 
% frames the prs symbols will be displayed in 
% continuous matched filter response
%
% Note: null has been manually removed
% SNR = 0dB
%================================================

close all
clear all

%% Dab mode used to generate file

dab_mode.K         = 1000;
dab_mode.L         = 5;
dab_mode.Tnull     = 0;
dab_mode.Tu        = 2048;
dab_mode.Tg        = 504;
dab_mode.Td        = 4*2048;
dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
dab_mode.Tp        = (dab_mode.L-1)*dab_mode.Ts;
dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
dab_mode.rep       = 5;
dab_mode.Tf        = (dab_mode.Tnull + dab_mode.Tp + dab_mode.Td);
dab_mode.f0        = 2.048e6;
dab_mode.ftx       = 2.048e6;

%% Generating PRS

prs = build_prs_custom(dab_mode);

%% Loading in data stream

iq_data = loadfersHDF5_iq("emission.h5");

iq_data = awgn(iq_data,0, "measured");

%% Preprocessing
% Extracting first pulse/frame

prs_idx = prs_detect_rad(iq_data,prs,dab_mode);

dab_frame = frame_extract_rad(iq_data, prs_idx, dab_mode);


%% Demodulation - SYMBOLS UNPACK
dab_symbols = symbols_unpack_rad(dab_frame, dab_mode);

figure
hold on

for i = 1:size(dab_symbols,1)
    
    subplot(size(dab_symbols,1),1,i)
    plot(1:1:length(dab_symbols), real(dab_symbols(i,:)))
    xlim tight
    xlabel("Sample [n]", "FontSize", 16)
    ylabel("Magnitude [Arb]", "FontSize", 16)
    
end



%% Demodulation - OFDM MUX
dab_carriers = ofdm_demux(dab_symbols); 

figure
hold on

for i = 1:size(dab_carriers,1)
    
    subplot(size(dab_carriers,1),1,i)
    plot(1:1:length(dab_carriers), abs(dab_carriers(i,:)))
    xlim tight
    ylim padded
    xlabel("Sample [n]", "FontSize", 16)
    ylabel("Magnitude [Arb]", "FontSize", 16)
    
end

%% Demodulation - DQPSK DEMAP 
dab_data_raw = dqpsk_demap_rad(dab_carriers, dab_mode);

figure
hold on

for i = 1:size(dab_data_raw,1)
    
    subplot(size(dab_data_raw,1),1,i)
    scatter(1:1:length(dab_data_raw), angle(dab_data_raw(i,:)))
    xlim tight
    ylim padded
    
    xlabel("Differential Phase Index [n]", "FontSize", 16)
    ylabel("Magnitude [Arb]", "FontSize", 16)
    yticks([ -3*pi/4 -pi/4 pi/4 3*pi/4])
    yticklabels(["-3\pi/4", "-\pi/4", "\pi/4", "3\pi/4"])
    
end

%% Demodulation - FREQ DEINTERLEAVE   (Not yet implemented)
dab_data_deinterleaved = dab_data_raw; 

%% Demodulation - DQPSK SNAP
dab_data_snapped = dqpsk_snap(dab_data_deinterleaved);

%% Demodulation - ERROR CORRECTION (Not yet implemented)
dab_data = error_correct(dab_data_snapped);

for i = 1:size(dab_data,1)
    
    subplot(size(dab_data_raw,1),1,i)
    scatter(1:1:length(dab_data), angle(dab_data(i,:)))
    xlim tight
    ylim padded
    
    xlabel("Differential Phase Index [n]", "FontSize", 16)
    ylabel("Magnitude [Arb]", "FontSize", 16)
    yticks([ -3*pi/4 -pi/4 pi/4 3*pi/4])
    yticklabels(["-3\pi/4", "-\pi/4", "\pi/4", "3\pi/4"])
    
end



