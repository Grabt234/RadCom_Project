% ---------------------------------------------------------------------    
% demo_plot_hdf_pulse_dab: reads an plots (as a verification) the pulse
% created in "create_hdf_pulse_dab"
% ---------------------------------------------------------------------  

%hdf5_file_name = "chirp.h5"
hdf5_file_name = "pulse_dab.h5"

%sampling frequency
fs = 2.048e6;
%the dab mode used
dab_mode = load_dab_constants(1)


%reading data from hdf5
cmplx_data = loadfersHDF5_iq(hdf5_file_name);

%%

%time axis
time = (1:1:length(cmplx_data))*(1/fs);


%plotting time domain envelope of frame
plot(time,cmplx_data)

%plot labels
xlabel("Time (seconds)");
ylabel("Amplitude (over 1 ohm resistor) (voltage)")
title("Time domaon envelope of DAB frame isolated from an hdf5 file");


%%

%creating a new figure to plot on
figure

%isolating useful symbols froma DAB frame
dab_symbols = symbols_unpack(dab_frame, dab_mode);

%converting from time fourier domain
dab_symbols = abs(fftshift(fft(dab_symbols,[],2),2));

%frequency axis
f = 1:1:length(dab_symbols(1,:));

%symbol axis
l = 1:1:dab_mode.L;

%plotting all symbols in frame
surf(f,l,dab_symbols)
title("absolute values FFT applied symbols contained in a DAB frame displayed  cube of ")
xlabel('Sub-carrier index') 
ylabel('Symbol Number L')

