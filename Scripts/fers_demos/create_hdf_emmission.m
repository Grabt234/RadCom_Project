% ---------------------------------------------------------------------    
% creates a simple plot of the "basis" waveform to be transmitted in fers
% ---------------------------------------------------------------------  

hdf5_file_name_tx = "pulse_dab_symbols.h5";
hdf5_file_name_rx = "response.h5"

%sampling frequency
fs = 2.0e6;
%the dab mode used
dab_mode = load_dab_constants(1);

%reading data from hdf5
pulse_tx = loadfersHDF5_iq(hdf5_file_name_tx);
response = loadfersHDF5_cmplx(hdf5_file_name_rx);

%% REVELEVANT SIMULATION PARAMTERS

prf = 10;
pulse_length = length(pulse_tx);
runtime = 0.6;

%% CREATING TRANSMITTED WAVEFORM

PRI = 1/prf;
PRI_samples = PRI*fs;
required_zeros = PRI_samples - pulse_length;
transmitted_pulses = (runtime*prf)
transmitted_integer_pulses = floor(runtime*prf)
transmitted_remainder_pulses = transmitted_pulses - transmitted_integer_pulses;

additional_zeros = zeros(1,required_zeros);
size(additional_zeros)
pulse = [pulse_tx additional_zeros];


pulses = repmat(pulse,1,transmitted_integer_pulses);


pulses = [pulses pulse_tx zeros(1, ceil(required_zeros*transmitted_remainder_pulses))];

size(pulses)
size(response,2)*1/fs


%% PLOTTING

%time axis
time1 = (1:1:length(response))*(1/fs);
time2 = (1:1:length(pulses))*(1/fs);


%plotting time domain envelope of frame
figure
plot(time1,response)
hold on
plot(time2,pulses)

%plot labels
xlabel("Time (seconds)");
ylabel("Amplitude (over 1 ohm resistor) (voltage)")
title("Time domaon envelope of DAB frame isolated from an hdf5 file");



