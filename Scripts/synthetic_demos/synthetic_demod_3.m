%% FILE DESCRIPTION
%=================================
% running iq data that was synthetically though (hopefully generalised) 
% DAB processing chain
%          
%=================================

%% LOADING IN INFORMATION
close all
dab_mode = load_dab_rad_constants(7);

fs = 2.5e6;
integrationInterval = 0.1;
filename = "rx.dat";
fileParams.fileType = 'Bin';
 


fileParams.fs=fs; %Sampling rate
%Integration interval
fileParams.interval = integrationInterval*fs; %samples
 

fileParams.r_fid = fopen(filename,'rb');

r_file = fread(fileParams.r_fid, 2*fileParams.interval,'double');

r_ch = r_file(1:2:end) + 1j*r_file(2:2:end);

r_ch = resample(r_ch,2.048e6, 2.5e6);


iq_data = r_ch.';
ax = (1:1:length(iq_data))*fs/length(iq_data) - fs/2;
plot(ax/1e6, abs(fftshift(fft(iq_data))))
figure
%% refernce read in

% hdf5_file_name = "emission.h5";
% iq_data = loadfersHDF5_iq(hdf5_file_name);
% 
% min snr: -2db
% iq_data = awgn(iq_data,10,"measured");
% 
% ax = (1:1:length(iq_data))*fs/length(iq_data) - fs/2;
% plot(ax/1e6, abs(fftshift(fft(iq_data))))
% figure

%%

f0 = 2.048e6;

%bits per per code
n = 2;

%% PLOTTING

subplot(2,2,1)
plot((1:1:length(iq_data)),iq_data)
title("RECEIVED SIGNAL")

%% PRS DETECT

prs = build_prs_custom(dab_mode);

frame_count_max = 3;
dab_frames = zeros(frame_count_max, dab_mode.Tf);
%frames currently extracted
frame_count = 0;

%% FRAME EXTRACTION
%move into a function eventually
while(1)

    %checking for a prs in symbol
    prs_idx = prs_detect_rad(iq_data,prs,dab_mode);

    %if run through data and found no prs
    if(prs_idx == -1)
        break
    end

    %%Frame Extraction
    %if prs found, extract frame, frame includes gaurd interval and prs
    dab_pulse = frame_extract_rad(iq_data, prs_idx, dab_mode);

    % incrementing number of frames
    frame_count = frame_count + 1;

    %inserting data into data cube
    dab_frames(frame_count,:) = dab_pulse;

    %removing extracted data from data stream
    iq_data = iq_data(prs_idx + dab_mode.Tf - dab_mode.Tnull:end);

    % check if we are at the end if iq_data
    if(length(iq_data) < dab_mode.Tf || frame_count  >= frame_count_max)
       
        break 
    end

end

%removing zeros
dab_frames = dab_frames(1:frame_count,:,:);

dab_frame = dab_frames(1,:);

%verifying frame extraction
subplot(2,2,2)
plot(1:1:length(dab_frame), dab_frame)
title("SINGLE FRAME")


%% DEMODULATING CONCATNATED PULSES

[dab_data, dab_carriers] = demodulate_rad(dab_frame, dab_mode);

%% CONVERTING PHASES TO BITS

%initialising phase codes array with first symbol
phase_codes = dab_data(1,dab_mode.mask);

%filling with remainder of symbols
for dd = 2:size(dab_data,1)
    
    phase_codes = [phase_codes dab_data(dd,dab_mode.mask)];
    
end



phase_codes = round(wrapTo360(rad2deg(angle(phase_codes))));

rx_bits = '';

mapper = define_inverse_alphabet_map(2);

for z = 1:numel(phase_codes)
    
   rx_bits = [rx_bits  mapper(phase_codes(z))];
   
end

%% CHECKING TX SAME AS RX


%reference bits
fileID = fopen('bits.txt','r');
ref_bits = fscanf(fileID,'%s');
fclose(fileID);

ref_bits

ref=char(num2cell(ref_bits));
ref=reshape(str2num(ref),1,[]);

output=char(num2cell(rx_bits));
output=reshape(str2num(output),1,[]);

rx_bits

results = rx_bits -ref_bits;
results = (string(results));
results = horzcat(results{:})

















































