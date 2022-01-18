
%================================================
% Demonstrates the isolation level between
% TX/RX and RX2 on USRP 1 and RX2 on USRP 2
%
%   TX gain = 30dB
%   RX gain = 00dB
%================================================

%% Reading in File

filenames = ["testbed/iso.00.dat" "testbed/iso.01.dat"];

for i = 1:2
    
    filename = filenames(i);

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
    
    %Frequency Domain
    subplot(1,2,i)
    plot(frequency, 20*log10(abs(fftshift(fft(rxp)./length(rxp)))));
    xlim([-1 1])
    ylabel("Level [dBm]")
    xlabel("Frequency [MHz]")
    title("RX2 - USRP " + num2str(i))

end

