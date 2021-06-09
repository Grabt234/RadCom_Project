% ---------------------------------------------------------------------    
% Creates a simple plot of the received signal from fers
% NOTE: BOFORE RUNNING THIS SCRIPT RUN THE FERS SIM AND RENAME OUTPUT
% ---------------------------------------------------------------------  

hdf5_file_name = "response.h5"

%sampling frequency
fs = 2.048e6;
%the dab mode used
dab_mode = load_dab_constants(1)


%reading data from hdf5
cmplx_data = loadfersHDF5_cmplx(hdf5_file_name);

%%

%time axis
time = (1:1:length(cmplx_data))*(1/fs);


%plotting time domain envelope of frame
plot(time,real(cmplx_data))

%plot labels
xlabel("Time (seconds)");
ylabel("Amplitude")



