% ---------------------------------------------------------------------    
% DAB_MODE  7
% ---------------------------------------------------------------------  

close all

%% HDF config

% %file name
% hdf5_file_name_emission = "_emission.h5"
% hdf5_file_name_response = "_response.h5"
% 
% 
% %reading data from hdf5
% cmplx_data_emission = loadfersHDF5_iq(hdf5_file_name_emission);
% cmplx_data_response = loadfersHDF5_cmplx(hdf5_file_name_response);
% 
% dab_mode = load_dab_rad_constants(7);
% %runtime of simulation (seconds)
% run_time = 0.02;
% %sampling frequency
% fs = 2.048e9;
% fc = 2.048e9;
% %window skip (time steos), no null in ths mode
% win_skip = dab_mode.Tf;
% %pulse repetition frequency
% prf = 25000;
% %the dab mode used
%     

%%
prf = 100;
integrationInterval = 0.5;
prt = 1/prf;
fc = 2.4e9;

%% Bin config

close all
dab_mode = load_dab_rad_constants(7);

fs = 2.5e6;

filename = "rx.dat";
fileParams.fileType = 'Bin';
fileParams.fs=fs; %Sampling rate

%Integration interval
fileParams.interval = integrationInterval*fs; %samples

fileParams.r_fid = fopen(filename,'rb');

%reading rx form file
r_file = fread(fileParams.r_fid, 2*fileParams.interval,'double');
rx = r_file(1:2:end) + 1j*r_file(2:2:end);
rx = resample(rx,2.6.114e6, 6.25e6);
rx = rx.';
fclose(fileParams.r_fid)

%plotting rx
ax = (1:1:length(rx))*fs/length(rx) - fs/2;
plot(ax/1e6, 20*log10(abs(fftshift(fft(rx)))))
figure

%% TX Data

tx  =  loadfersHDF5_iq("emission.h5");

figure
subplot(2,2,1)  
plot((1:1:length(tx))*(1/fs), tx)
title("PLOT SHOWING TX PULSE TRAIN")

%% CUTTING INTO SLOW TIME SAMPLES

%preallocating memory
fs = 2.048e6;

slow_time = zeros(floor(integrationInterval*prf), floor((1/prf)*fs));

i=0;

while length(rx) >= (1/prf)*fs
    
    i = i + 1;
    %stroing slow time sample
    slow_time(i,:) = rx(1:(1/prf)*fs);
    %removing slow time sample
    rx = rx((1/prf)*fs:end);
    
    if(i*prt > integrationInterval)
        break
    end
end

%showing single pulse
subplot(2,2,2)
plot((1:1:length(slow_time(1,:)))*(1/fs),slow_time(1,:))
title("SINGLE RECEIVED PULSE")

%% MATCHING
slow_time = slow_time(2:end,:);

%creating matched filter (there is a size mismatch)
mf = [tx zeros(1, prt*fs - length(tx))];
mf = conj(flip(mf));

RD = zeros(size(slow_time,1), length(conv(mf, slow_time(1,:))));

for i = 1:size(slow_time,1)
    
    RD(i,:) = conv(mf, slow_time(i,:) );

end

RD = fftshift(fft(RD,[],1),1);

figure
s = surf(10*log10(abs(RD)));
set(s,"linestyle", "none")
% %moving to frequency domain
% MF = fft(mf);
% %upscaling ro rx bins size
% MF = repmat(MF, size(slow_time,1), 1);

% RX = fft(slow_time,[],2);
% 
% MF = MF(:,length(MF)/2:end);
% RX=  RX(:,length( RX)/2:end);
% 
% %matching
% RD = RX.*MF;
% RD = fftshift((ifft2(RD)),1);
%         
% %moving range to correct bins
% RD = flip(RD,2);
%         
% %normalising
% RD = RD/max(RD,[],"all");


% 
% fast_time = size(RD,2);
% slow_time = size(RD,1);
% 
% range axis
% r_axis = (1:1:fast_time)*(1/fc)*(3e8/(2*1000));
% 
%velocity axis
%SIMPLIFY THIS AXIS 
% v_axis = (-slow_time/2:1:slow_time/2)*(prf/slow_time)*(1/fs)*(3e8/2);

% figure
% su = surf(10*log10(abs(RD)));
% set(su,"linestyle", "none")
% 
% %plotting
% % Rimagesc(r_axis , v_axis  ,10*log10(abs(range_response)))
% xlabel("Range (Km)")
% ylabel("Velocity (m/s)")



















