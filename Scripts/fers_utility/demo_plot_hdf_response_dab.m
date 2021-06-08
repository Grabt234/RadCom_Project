% ---------------------------------------------------------------------    
% demo_plot_hdf_pulse_dab: reads an plots (as a verification) the pulse
% created in "create_hdf_pulse_dab"
% ---------------------------------------------------------------------  

%hdf5_file_name = "chirp.h5"
hdf5_file_name = "monostatic.h5"

%sampling frequency
fs = 2.048e6;
%the dab mode used
dab_mode = load_dab_constants(1)


%reading data from hdf5
cmplx_data = loadfersHDF5_cmplx(hdf5_file_name);

%%

%time axis
time = (1:1:length(cmplx_data))*(1/10e6);


%plotting time domain envelope of frame
plot(time,real(cmplx_data))

%plot labels
xlabel("Time (seconds)");
ylabel("Amplitude")



