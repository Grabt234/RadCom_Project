% ---------------------------------------------------------------------    
% DAB_MODE  7
% ---------------------------------------------------------------------  

close all


%% CONFIGURABLES

%file name
hdf5_file_name_emission = "cw_emission.h5"
hdf5_file_name_ref = "cw_response_surv.h5"
hdf5_file_name_response = "cw_response.h5"

%reading data from hdf5
RefData = loadfersHDF5_cmplx(hdf5_file_name_ref);
cmplx_data_emission = loadfersHDF5_iq(hdf5_file_name_emission);
cmplx_data_response = loadfersHDF5_cmplx(hdf5_file_name_response);


dab_mode = load_dab_rad_constants(4);
%runtime of simulation (seconds)
run_time = 0.2; %s
%sampling frequency
fs = 2.048e7; %hz
%carrier frequency
fc = 2.4e9; %hz       
max_range = 200000 %meters
%window skip (time steos), no null in ths mode
win_skip = 0;
%PRF - (time to repeat cw)
prf = floor(1/(dab_mode.Tf*1/fs));

%matched filter size
%blanking is done automatically
match_start_symbol = 1;
match_end_symbol = 5;

%aligns signals - removes range offset from matched filter offset start 
start_offset = (match_start_symbol)*dab_mode.Ts;
match_length = (match_end_symbol-match_start_symbol)*dab_mode.Ts;

cmplx_data_response = cmplx_data_response(start_offset:end);

%accurate speed of light
c =299792458;

%% PLOTTING  READ DATA

figure
subplot(2,2,1)  
plot((1:1:length(cmplx_data_response)), cmplx_data_response)
title("PLOT SHOWING RECEIVED PULSE TRAIN")

%% CUTTING INTO SLOW TIME SAMPLES
    
%preallocating memory
slow_time = zeros(floor(run_time*prf), floor((1/prf)*fs));

i=0;

while length(cmplx_data_response) >= (1/prf)*fs
    
    i = i + 1;
    %storing slow time sample
    slow_time(i,:) = cmplx_data_response(1:floor((1/prf)*fs));
    %removing slow time sample
    cmplx_data_response = cmplx_data_response(floor((1/prf)*fs):end);
    
end

max_index = ceil(max_range*2*fs/c);
slow_time = slow_time(:,1:max_index);

%showing single pulse
subplot(2,2,2)
plot((1:1:length(slow_time(1,:))),slow_time(1,:))
title("SINGLE RECEIVED PULSE")

%% MATCHING

%preallocating memory
matched_filter = cmplx_data_emission(1,match_start_symbol*dab_mode.Ts:match_end_symbol*dab_mode.Ts);

%total number of symbols in filter
symbols = match_end_symbol - match_start_symbol;

%blanking guard interval
for k = 1:symbols
    
    %start and end index for guard interval
    s = 1 + (k-1)*dab_mode.Ts;
    e = s+dab_mode.Tg -1;
    %blanking
    matched_filter(s:e) = 0;
    
end

%flipping and taking conjugate
%now have filter
matched_filter = conj(fliplr(matched_filter));

%matched_filter = conj(fliplr(cmplx_data_emission(1,match_start:match_end)));

%plotting filter
subplot(2,2,3)
plot(1:1:length(matched_filter),matched_filter)
title("Matched Filter")

%% SLOW TIME - FILTER CONVOLUTION

%plottng matched response with prs from range bin
prs_bin_response = abs(conv(matched_filter,squeeze(slow_time(1,:))));
subplot(2,2,4)
plot(1:1:length( prs_bin_response), prs_bin_response)
title("MATCHED RESPONSE")

%preallocating memory
range_response = zeros(ceil(run_time*prf),length(conv(matched_filter,slow_time(1,:))));

for j = 1:i
    
    range_response(j,:) = conv(matched_filter,slow_time(j,:));
    disp(j/i);
    
end

%% FFT'ING ALONG COLUMNS

%taking fft
range_response = fftshift(fft(range_response,[],1),1);

%normalising 
range_response = range_response/max(range_response,[], 'all');

%% CUTTING

% %limiting plot to max range
% max_index = ceil(max_range*2*fs/c);
% range_response = range_response(:,1:max_index);

%% PLOTTING RANGE DOPPLER

%axes sizes
fast_time = size(range_response,2);
slow_time = size(range_response,1);

%range axis scaling
r_axis = (1:1:fast_time)*(1/fs)*(c/(2*1000));

%velocity axis
v_axis = ((-slow_time/2:1:slow_time/2))*(prf/slow_time)*(1/fc)*(c/2);

%plotting image
figure
imagesc(r_axis , v_axis  ,(abs(range_response)))
xlabel("Range (Km)")
ylabel("Velocity (m/s)")








