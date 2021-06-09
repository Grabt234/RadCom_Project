% ---------------------------------------------------------------------    
% creates a simple plot of the "basis" waveform to be transmitted in fers
% ---------------------------------------------------------------------  

hdf5_file_name = "pulse_dab_symbols.h5";

%sampling frequency
fs = 2.048e6;
%the dab mode used
dab_mode = load_dab_constants(1);


%reading data from hdf5
cmplx_data = loadfersHDF5_iq(hdf5_file_name);

%% PLOTTING SINGLE TRANSMITTED WAVEFORM

%time axis
time = (1:1:length(cmplx_data))*(1/fs);


%plotting time domain envelope of frame
figure
plot(time,cmplx_data)

%plot labels
xlabel("Time (seconds)");
ylabel("Amplitude (over 1 ohm resistor) (voltage)")
title("Time domaon envelope of DAB frame isolated from an hdf5 file");



