
%================================================
% Demonstrates and validates the recording of an 
% LFM waveform from signal gen and recorded on
% USRP
%
% Notes that the file need to be generated by
% running the ettus code and renaming/moving
% the file into this directory
%
% LFM Params: BW: 500KHz, Pulse width: 500us
%               Pulse Period: 1ms
%
% Total Attenuation: 50dB
%================================================

%% Reading in File

filename = "testbed/rx.01.dat"; %file name;

r_fid = fopen(filename,'rb'); %openign bin file

fs = 2.5e6; %sampling rate of ettus

interval = 3; %seconds

samples = interval*fs*2; %I and Q

%reading rx form file
r_file = fread(r_fid, samples ,'double');

%changing into complex numbers
rx = r_file(1:2:end) + 1j*r_file(2:2:end);

%converting to row (personal preference)
rx = rx.';

%clsoing opened bin file
fclose(r_fid);

%% Plotting

plot_samples_start = 500e3; %how many samples per plot

plot_samples_stop = 3500e3; %how many samples per plot

plot_length = plot_samples_stop - plot_samples_start;

time = (1:1:plot_length)*1/fs; %time_axis

rxp = rx(plot_samples_start+1:plot_samples_stop); %removes transient

%Time domain
subplot(1,2,1)
plot(time*1e6, real(rxp))
xlim([50000 55000])
ylabel("Amplitude [V]")
xlabel("Time [\mus]")

frequency = 1:1:plot_length;
frequency = (frequency-length(frequency)/2)*(fs/length(time))/1e6; % MHz

%Frequency Domain
subplot(1,2,2)
plot(frequency, 20*log10(abs(fftshift(fft(rxp)./length(rxp)))));
xlim([-0.8 0.8])
ylim([-130 -80])
ylabel("Level [dBm]")
xlabel("Frequency [MHz]")


