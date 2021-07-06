%% FILE DESCRIPTION
%=================================
% running iq data that was synthetically though (hopefully generalised) 
% DAB processing chain
%=================================

%% LOADING IN INFORMATION

hdf5_file_name = "synthetic_encoded_data.h5"
iq_data = loadfersHDF5_iq(hdf5_file_name);

dab_mode = load_dab_rad_constants(2);

f0 = 2.048*10^8;

%% PLOTTING

plot((1:1:length(iq_data)),iq_data)

%% PRS DETECT

prs = build_prs_custom(dab_mode);

%frames currently extracted
frame_count = 0;

%% PULSE EXTRACTION

while(1)

    %checking for a prs in symbol
    prs_idx = prs_detect_rad(iq_data,prs,dab_mode)

    %if run through data and found no prs
    if(prs_idx == -1)
        break
    end

    %%Frame Extraction
    %if prs found, extract frame, frame includes gaurd interval and prs
    dab_pulse = frame_extract_rad(iq_data,prs_idx,dab_mode);

    % incrementing number of frames
    frame_count = frame_count + 1;

    %inserting data into data cube
    dab_frames(frame_count,:) = dab_pulse;

    %removing extracted data from data stream
    iq_data = iq_data(prs_idx + (dab_mode.Tf+ dab_mode.T_intra)*dab_mode.F_intra - dab_mode.Tnull:end);

    % check if we are at the end if iq_data
    if(length(iq_data) < (dab_mode.Tf+ dab_mode.T_intra)*dab_mode.F_intra || frame_count  >= frame_count_max)
        break 
    end

end

%removing zeros
dab_frames = dab_frames(1:frame_count,:,:);
