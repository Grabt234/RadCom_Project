%% SAMPLING DEFS

f0 = 2.048e6;
T = 1/f0;
frame_count_max = 15;

%% PLOTTING WAVEFORM

% iq = loadfersHDF5_iq('validation.h5');
% iq = loadfersHDF5_cmplx('monostatic.h5');
% plot(linspace(1,length(iq),length(iq)),iq);

%% IMPORTING TRANSMITTED FRAME

dab_mode = load_dab_rad_constants(2)

iq_tx = loadfersHDF5_iq('test.h5');

% [dab_pulses_tx, ~, iq_data_tx] = batch_process_frames( ...
%                     'test.h5', frame_count_max,dab_mode_2, f0,2);

%%  PROCESSING RECEIVED FERS SIGNAL
%  
 [dab_frames, frame_count, iq_data_rx] = batch_process_frames( ...
                     'monostatic_10.h5', frame_count_max,dab_mode, f0,1);

%% TEMPORARY

% figure
% plot(1:size(iq_data_rx,2), iq_data_rx)

%removing null symbol
dab_frames = dab_frames(:,dab_mode.Tnull:end);

%removing interframe time
dab_frames = dab_frames(:,1:end - dab_mode.T_intra);

figure 
plot(1:size(dab_frames(2,:),2), dab_frames(2,:))
%% MATCHED FILTER EXAMPLE

%removing last interframe time
iq_tx = iq_tx(dab_mode.T_intra+dab_mode.Tnull:end);

%removing null symbol
iq_tx = iq_tx(dab_mode.Tnull:end)

%building matched filter
matched_filter = build_matched_filter(iq_tx);

figure
plot(1:size(matched_filter,2), matched_filter);
title('The matched filter');

%calculating matched response
response = abs(conv(matched_filter, dab_frames(1,:)));

figure
plot(1:size(response,2), response);
title('A matched filter response example');

%% MATCHING FRAMES

range_doppler = zeros(frame_count, length(response));

for i =  1:frame_count
    range_doppler(i,:) = conv(dab_frames(i,:),matched_filter);
end


%normalising 
range_doppler = range_doppler;

%taking the doppler across slowtime
range_doppler = fft(range_doppler, [], 1)./length(range_doppler);
%plot(1:size(range_doppler,2),(abs(range_doppler(1,:))));

range_doppler = range_doppler./max(range_doppler,[],"all");

range_doppler = range_doppler(:,2600:end-2000);

imagesc(10*log(abs(range_doppler)))






