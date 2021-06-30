% ---------------------------------------------------------------------    
% 
% ---------------------------------------------------------------------  

%file name
hdf5_file_name_emission = "synthetic_emission.h5"
hdf5_file_name_response = "synthetic_response.h5"


%reading data from hdf5
cmplx_data_emission = loadfersHDF5_iq(hdf5_file_name_emission);
cmplx_data_response = loadfersHDF5_cmplx(hdf5_file_name_response);

%%
%runtime of simulation (seconds)
run_time = 0.02;
%sampling frequency
fs = 20.48e6;
%window skip (time steos)
win_skip = ceil(249.2e-6*fs);
%pulse repetition frequency
prf = 400;
%the dab mode used
dab_mode = load_dab_rad_constants(3);

%% PLOTTING  READ DATA

figure
subplot(2,2,1)  
plot(1:1:length(cmplx_data_response), cmplx_data_response)


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
plot((1:1:length(slow_time(1,:))),slow_time(1,:))

%% CUTTING INTO RANGE BINS

range_bins = zeros(ceil(run_time*prf), floor((1/prf)*fs/win_skip), win_skip);

i = 0;

%again, could not get reshape to work
while length(slow_time) >= win_skip
    
    i = i + 1;
    %stroing slow time sample
    range_bins(:,i,:) = reshape(slow_time(:,1:win_skip),[],1,win_skip);
    %removing slow time sample
    slow_time = slow_time(:,win_skip:end);
    
end


subplot(2,2,3)
prs_pos = 1;
plot((1:1:length(squeeze(range_bins(1,prs_pos,:)))),squeeze(range_bins(1,prs_pos,:)))

%% MATCHING
 
%creating matched filter (there is a size mismatch)
matched_filter = conj(fliplr(cmplx_data_emission));

%plottng matched response with prs from range bin
prs_bin_response = abs(conv(matched_filter,squeeze(range_bins(1,prs_pos,:))));
subplot(2,2,4)
plot(1:1:length( prs_bin_response), prs_bin_response)

%preallocating memory
range_response = zeros(ceil(run_time*prf),size(matched_filter, 1));

for i = 1:run_time*prf
    
    for j = 1:floor((1/prf)*fs/win_skip)
        
        range_response(i,j) = max((conv(matched_filter, squeeze(range_bins(i,j,:)))));
        
    end
    
    
end

figure
range_response = fft(range_response,[],1);

range_response = range_response/max(range_response,[], 'all');

imagesc(10*log10(abs(range_response)))


