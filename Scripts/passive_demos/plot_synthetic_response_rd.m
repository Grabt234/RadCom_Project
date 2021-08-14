% ---------------------------------------------------------------------    
% DAB_MODE  7
% ---------------------------------------------------------------------  

close all


%% CONFIGURABLES

%file name
hdf5_file_name_emission = "cw_emission.h5"
hdf5_file_name_ref = "cw_response_surv.h5"
hdf5_file_name_response = "cw_response.h5"

max_range = 25000; %in samples

%reading data from hdf5
RefData = loadfersHDF5_cmplx(hdf5_file_name_ref);
cmplx_data_emission = loadfersHDF5_iq(hdf5_file_name_emission);
cmplx_data_response = loadfersHDF5_cmplx(hdf5_file_name_response);

% cmplx_data_response = cmplx_data_response;
% RefData = RefData(1:length(cmplx_data_response));

dab_mode = load_dab_rad_constants(3);
%runtime of simulation (seconds)
run_time = 0.25;
%sampling frequency
fs = 2.048e7;
fc = 2.4e9;
%window skip (time steos), no null in ths mode
win_skip = 0;

%to align 
match_start = 1;
match_end = 1*dab_mode.Ts;
start_offset = match_start;

cmplx_data_response = cmplx_data_response(start_offset+1:end);

prf = floor(1/(dab_mode.Tf*1/fs));

%% PULSE CANCELLATION

proc.cancellationMaxRange_m = 50000;
proc.cancellationMaxDoppler_Hz = 16;
proc.TxToRefRxDistance_m = 1;
proc.nSegments = 16;
proc.nIterations = 50;
proc.Fs = fs;
proc.alpha = 0;
proc.initialAlpha = 0;
   
cmplx_data_response = CGLS_Cancellation_RefSurv(RefData.', cmplx_data_response.', proc);
cmplx_data_response = cmplx_data_response.';
a = cmplx_data_response;
%     

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

%reducing processing range
slow_time = slow_time(:,1:max_range);
size(slow_time)

%showing single pulse
subplot(2,2,2)
plot((1:1:length(slow_time(1,:))),slow_time(1,:))
title("SINGLE RECEIVED PULSE")

%% MATCHING
 
%creating matched filter (there is a size mismatch)
matched_filter = conj(fliplr(cmplx_data_emission(match_start:match_end)));

%plottng matched response with prs from range bin
prs_bin_response = abs(conv(matched_filter,squeeze(slow_time(1,:))));
subplot(2,2,4)
plot(1:1:length( prs_bin_response), prs_bin_response)
title("MATCHED RESPONSE")

%preallocating memory
range_response = zeros(ceil(run_time*prf),length(conv(matched_filter,slow_time(1,:))));

for j = 1:i
    
    range_response(j,:) = conv(matched_filter,slow_time(j,:));
    j/i
end

%% PLOTTING FIGURE
figure
range_response = fftshift(fft(range_response,[],1),1);

range_response = range_response/max(range_response,[], 'all');


fast_time = size(range_response,2);
slow_time = size(range_response,1);

%range axis
r_axis = (1:1:fast_time)*(1/fs)*(3e8/(2*1000));

%velocity axis
%SIMPLIFY THIS AXIS

v_axis = ((-slow_time/2:1:slow_time/2))*(prf/slow_time)*(1/fc)*(3e8/2);

%plotting
imagesc(r_axis , v_axis  ,(abs(range_response)))
xlabel("Range (Km)")
ylabel("Velocity (m/s)")







