
%'validation_wf.h5' - uses dab_mode_2

osf = 5;
f0 = 2.048e8;
T = 1/f0;
pulse_count_max = 10;

%% PLOTTING WAVEFORM

iq = loadfersHDF5_iq('validation.h5');
plot(linspace(1,length(iq),length(iq)),iq);

%% EXTRACTING PULSES

dab_mode_2 = load_dab_rad_constants(2);

%% FINDING PULSES

[dab_frame, frame_count, iq_data_tx] = batch_process_frames( ...
                    'validation.h5', pulse_count_max,dab_mode_2, osf*f0,2);

%% EXAMPLE OF PLOTTED FRAMES

figure
plot(linspace(1,length(iq_data_tx),length(iq_data_tx)),iq_data_tx)
title('transmitted frame')

%% SYMBOL EXTRACTION
% 
% pulse  = dab_frame(1,:);

% figure
% plot(linspace(1,length(pulse),length(pulse)),pulse)
% title("Pulse with inter pulse time")
% %remove inter pulse time
% 
% pulse = pulse(dab_mode.T_intra:end)
% 
% figure
% plot(linspace(1,length(pulse),length(pulse)),pulse)
% title("Pulse without inter pulse time")
% 
% %removing NS
% pulse = pulse(dab_mode.Tnull:end)
% 
% figure
% plot(linspace(1,length(pulse),length(pulse)),pulse)
% title("Pulse without Null symbol")
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 


















