%================================================
% Given a sequence with arbitrary number of 
% frames the prs symbols will be displayed in 
% continuous matched filter response
%
% Note: null has been manually removed
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

figure
subplot(2,1,1)
plot(1:1:length(iq_data), real(iq_data));
xlim tight
xlabel("Sample [n]", "FontSize", 16)
ylabel("Magnitude [Arb]", "FontSize", 16)

%% Extracting first pulse/frame

prs_idx = prs_detect_rad(iq_data,prs,dab_mode);

dab_pulse = frame_extract_rad(iq_data, prs_idx, dab_mode);

subplot(2,1,2)
plot(1:1:length(dab_pulse), real(dab_pulse));
xlim tight
xlabel("Sample [n]", "FontSize", 16)
ylabel("Magnitude [Arb]", "FontSize", 16)



