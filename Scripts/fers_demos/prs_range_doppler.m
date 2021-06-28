% ---------------------------------------------------------------------    
% demo_fers_emission_response_compare: plots the first emission followed by
% all the recieved pulses. 
%
% note: the difference between start of first transmission and first
% response in the propogation delay and therefore the range of the target
% ---------------------------------------------------------------------  

%file name of emmitted and recieved pulse
hdf5_file_name_emission = "emission.h5"
hdf5_file_name_response = "response.h5"

%sampling frequency
fs = 2.048e6;
%window skip (time steos)
win_skip = ceil(1246e-6*fs);
%pulse repetition frequency
prf = 10;
%the dab mode used
dab_mode = load_dab_constants(1);


%reading data from hdf5
cmplx_data_emission = loadfersHDF5_iq(hdf5_file_name_emission); 
cmplx_data_response = loadfersHDF5_cmplx(hdf5_file_name_response);


%only working with a single recieved pulse
cmplx_data_response = cmplx_data_response(1:(1/prf)*fs);
%showing single pulse
figure
plot((1:1:length(cmplx_data_response))*(1/fs), cmplx_data_response)

%cutting into range bins (hardcoded number of bins)
range_bins = range_bins(win_skip:end)
range_bins = reshape(cmplx_data_response,100,[]);
range_bins = range_bins(1:99)
a=19
range_bins = cmplx_data_response(1+2048*a:2048*(a+1));

%creating matched filter
matched_filter = conj(fliplr(cmplx_data_emission));

% %preallocating memory
% range_response = zeros(1,100);
% 
% for i = 1:100
%     
%     range_response(1,i) = max(abs(conv(matched_filter, range_bins(i,:))));
%     
% end

figure

plot(1:1:length(range_bins),range_bins)




































