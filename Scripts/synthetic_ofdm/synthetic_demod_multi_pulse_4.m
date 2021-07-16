%% FILE DESCRIPTION
%=================================
% running iq data that was synthetically though (hopefully generalised) 
% DAB processing chain
%=================================

%% LOADING IN INFORMATION

hdf5_file_name = "synthetic_encoded_data.h5"
iq_data = loadfersHDF5_iq(hdf5_file_name);

dab_mode = load_dab_rad_constants(2);

f0 = 2.048*10^9;

%bits per per code
n = 2;

%% PLOTTING

% plot((1:1:length(iq_data)),iq_data)

%% PRS DETECT

prs = build_prs_custom(dab_mode);

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
figure
plot(1:1:length(dab_frame), dab_frame)
title("DAB frame plot")

%%  PULSE EXTRACTION

%preallocating memory for pulses
dab_pulses = zeros(dab_mode.p_intra, dab_mode.Tp);

%+1 accounts for the array pos starting at 1
pulse_idx = dab_mode.T_intra+1;

%iterating through every pulse WITHIN A COHERENT FRAME
for pulse = 1:dab_mode.p_intra
    
    dab_pulses(pulse,:) = dab_frame(1,pulse_idx :(pulse_idx+dab_mode.Tp-1));
    
    pulse_idx =  pulse_idx + dab_mode.Tp + dab_mode.T_intra;

end

%verifing pulse extraction
% figure
% subplot(2,1,1)
% plot(1:1:length( dab_pulses(1,:)),  dab_pulses(1,:))
% title("pulse 1")
% subplot(2,1,2)
% plot(1:1:length( dab_pulses(2,:)),  dab_pulses(2,:))
% title("pulse 2")


%% CONCATNATING 2+ PULSES

concatnated_pulses = dab_pulses(1,:);

for pulse = 2:dab_mode.p_intra
      
   concatnated_pulses = [concatnated_pulses dab_pulses(pulse,1+dab_mode.Tnull:end)];

end

% figure
% plot(1:1:length(concatnated_pulses),  concatnated_pulses)
% title("concatnated pulses")


%% DEMODULATING CONCATNATED PULSES

[dab_data, dab_carriers] = demodulate_rad(concatnated_pulses, dab_mode);
 
% wrapTo360(rad2deg(angle(dab_data(1, dab_mode.mask))))
% wrapTo360(rad2deg(angle(dab_data(2, dab_mode.mask))))
%rad2deg(angle(dab_data(3, dab_mode.mask)))

%% CONVERTING PHASES TO BITS

phase_codes = dab_data(1,dab_mode.mask);

for dd = 2:size(dab_data,1)
    
    phase_codes = [phase_codes dab_data(dd,dab_mode.mask)];
    
end

mapper = define_inverse_alphabet_map(2);

phase_codes = round(wrapTo360(rad2deg(angle(phase_codes))));

transmitted_bits = '';

for z = 1:numel(phase_codes)
    
   transmitted_bits = [transmitted_bits  mapper(phase_codes(z))];
   
end

transmitted_bits
























































