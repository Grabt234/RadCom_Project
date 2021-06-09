% ---------------------------------------------------------------------    
% creates a simple plot of the emmitted wavewofrm in fers
% ---------------------------------------------------------------------  

%hdf5 file name
hdf5_file_name_tx = "pulse_dab_symbols.h5";

%sampling frequency
fs = 2.048e6;
%the dab mode used
dab_mode = load_dab_constants(1);

%reading data from hdf5
pulse_tx = loadfersHDF5_iq(hdf5_file_name_tx);

%% REVELEVANT SIMULATION PARAMTERS
%these need to relate to the fer sim xml file
prf = 10;
pulse_length = length(pulse_tx);
runtime = 0.25;

%% CREATING TRANSMITTED WAVEFORM

%pulsed radar parameters
PRI = 1/prf;
PRI_samples = PRI*fs;
required_zeros = PRI_samples - pulse_length;

%calculating integer number of pulses transmited
transmitted_pulses = (runtime*prf);
transmitted_integer_pulses = floor(runtime*prf);

%storing the amount of ectra time the simulation run for
transmitted_remainder_pulses = transmitted_pulses - transmitted_integer_pulses;

%creating a single PRI
additional_zeros = zeros(1,required_zeros);
pulse = [pulse_tx additional_zeros];

%concatnating PRI's
pulses = repmat(pulse,1,transmitted_integer_pulses);

%adding on remainder PRI in the case run time not integer multiple of PRI
pulses = [pulses pulse_tx zeros(1, ceil(required_zeros*transmitted_remainder_pulses))];

%% PLOTTING

%time axis
time2 = (1:1:length(pulses))*(1/fs);

%plotting time domain envelope of frame
figure
plot(time2,pulses)

%plot labels
xlabel("Time (seconds)");
title("Time domain envelope of transmitted signal");

%% WRITE TO HDF5 FILE

create_hdf5('emission',pulses);

