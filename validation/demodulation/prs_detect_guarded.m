%================================================
% Given a sequence with arbitrary number of 
% frames the prs symbols will be displayed in 
% continuous matched filter response
%================================================

close all
clear all

%% Dab mode used to generate file

dab_mode.K         = 1000;
dab_mode.L         = 3;
dab_mode.Tnull     = 0;
dab_mode.Tu        = 2048;
dab_mode.Tg        = 504;
dab_mode.Td        = 4*2048;
dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
dab_mode.rep       = 5;
dab_mode.Tf        = (dab_mode.Tp + dab_mode.Td)*dab_mode.rep;
dab_mode.f0        = 2.048e6;
dab_mode.ftx       = 2.048e6;

%% Generating MF from hdf5

mf = loadfersHDF5_iq("prs_det_emission_single_guarded.h5");
mf = mf(1:dab_mode.Ts);
mf = conj(flip(mf));

figure
subplot(4,1,1)
plot(1:1:length(mf), real(mf))
xlim tight
ylim padded
xlabel("Sample [n]", "FontSize", 16)
ylabel("Magnitude [Arb]", "FontSize", 16)

%% Loading in a long signal to do multi PRS detection

s = loadfersHDF5_iq("prs_det_emission_guarded.h5");

subplot(4,1,2)
plot(1:1:length(s), real(s))       
xlim tight
ylim padded
xlabel("Sample [n]", "FontSize", 16)
ylabel("Magnitude [Arb]", "FontSize", 16)

%% Adding noise

s = awgn(s,-10, "measured");
subplot(4,1,3)
plot(1:1:length(s), real(s))       
xlim tight
ylim padded
xlabel("Sample [n]", "FontSize", 16)
ylabel("Magnitude [Arb]", "FontSize", 16)

%% Demonstrating multi match

mf_resp = conv(s, mf);

subplot(4,1,4)
plot(1:1:length(mf_resp), abs(mf_resp))
xlim tight
ylim padded
xlabel("Sample [n]", "FontSize", 16)
ylabel("Magnitude [Arb]", "FontSize", 16)




