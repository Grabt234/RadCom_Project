% ---------------------------------------------------------------------    
% FERS SIM
% TARGET RANGE: 
% VELOCITY:     0   M/S
% ---------------------------------------------------------------------  

close all

%file name
hdf5_file_name_emission = "shf_emission.h5"
hdf5_file_name_response = "shf_response.h5"


%reading data from hdf5
cmplx_data_emission = loadfersHDF5_iq(hdf5_file_name_emission);
cmplx_data_response = loadfersHDF5_cmplx(hdf5_file_name_response);

%%
dab_mode = load_dab_rad_constants(5);
%runtime of simulation (seconds)
run_time = 0.02;
%sampling frequency
fs = 2.048e9;
%window skip (time steos)
win_skip = dab_mode.Ts*(dab_mode.L-1)+dab_mode.Tnull;
%pulse repetition frequency
prf = 10000;
%the dab mode used
    

%% PLOTTING  READ DATA

figure
subplot(2,2,1)  
plot((1:1:length(cmplx_data_response))*(1/fs), cmplx_data_response)
title("PLOT SHOWING RECEIVED PULSE TRAIN")

%% CUTTING INTO SLOW TIME SAMPLES

%preallocating memory
slow_time = zeros(ceil(run_time*prf), (1/prf)*fs);

i=0;

while length(cmplx_data_response) >= (1/prf)*fs
    
    i = i + 1;
    %stroing slow time sample
    slow_time(i,:) = cmplx_data_response(1:(1/prf)*fs);
    %removing slow time sample
    cmplx_data_response = cmplx_data_response((1/prf)*fs:end);
    
end

%showing single pulse
subplot(2,2,2)
plot((1:1:length(slow_time(1,:)))*(1/fs),slow_time(1,:))
title("SINGLE RECEIVED PULSE")

%% MATCHING
 
%creating matched filter (there is a size mismatch)
matched_filter = conj(fliplr(cmplx_data_emission));

% %plottng matched response with prs from range bin
% prs_bin_response = abs(conv(matched_filter,squeeze(range_bins(1,prs_pos,:))));
% subplot(2,2,4)
% plot(1:1:length( prs_bin_response), prs_bin_response)
% title("MATCHED RESPONSE")

%preallocating memory
range_response = zeros(ceil(run_time*prf),length(conv(matched_filter,slow_time(1,:))));

for j = 1:i
    
    range_response(j,:) = conv(matched_filter,slow_time(j,:));
    
end

%% PLOTTING FIGURE
figure
range_response = fftshift(fft(range_response,[],1),1);

range_response = range_response/max(range_response,[], 'all');

%range axis
r_axis = (1:1:size(range_response,2))*(1/fs)*(3e8/(2*1000));

%velocity axis
v_axis = -1*flip((-size(range_response,1)/2:1:size(range_response,1)/2),2)*(prf/size(range_response,1)*(60*60*1/1000));

%plotting
imagesc(r_axis , v_axis  ,10*log10(abs(range_response)))
xlabel("Range (Km)")
ylabel("Velocity (m/s)")





















