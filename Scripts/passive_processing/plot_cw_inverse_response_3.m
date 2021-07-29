% ---------------------------------------------------------------------    
% FERS SIM
% TARGET RANGE: 
% VELOCITY:     0   M/S
% ---------------------------------------------------------------------  

close all

%file name
hdf5_file_name_emission = "base_emission.h5"
%hdf5_file_name_emission = "cw_emission.h5"
hdf5_file_name_response = "cw_response.h5"


%reading data from hdf5
cmplx_data_emission = loadfersHDF5_iq(hdf5_file_name_emission);
cmplx_data_response = loadfersHDF5_cmplx(hdf5_file_name_response);
iq_data = cmplx_data_response;
%cmplx_data_response = loadfersHDF5_iq(hdf5_file_name_response);

cmplx_data_response =resample(cmplx_data_response,10,1);
% up_samp = 10;
% down_samp = 1;
%cmplx_data_response = resample(cmplx_data_response,up_samp,down_samp);


plot((1:1:length(cmplx_data_emission)),cmplx_data_emission)
figure
% matched_filter = conj(fliplr(cmplx_data_emission));
% a = conv(matched_filter,cmplx_data_response);
% %a = cmplx_data_response;
% plot((1:1:length(a))*(1/2.048e9),(a))
% %%
dab_mode = load_dab_rad_constants(3);
%runtime of simulation (seconds)
run_time = 0.008;
%sampling frequency
fs = 2.048e7;
%window skip (time steos)
win_skip = 0;
%pulse repetition frequency
%for a continous version 1/frametime
prf = 1/(12750*(1/fs));
%the dab mode used
%     
% 
% %% PLOTTING  READ DATA
% 
figure
subplot(2,3,1)  
plot((1:1:length(cmplx_data_emission)),(cmplx_data_emission))
title("PLOT SHOWING RECEIVED PULSE TRAIN")

subplot(2,3,2)  
plot((1:1:length(cmplx_data_response)),(cmplx_data_response))
title("PLOT SHOWING RECEIVED PULSE TRAIN")

prs = build_prs_custom(dab_mode);

%
frame_count_max = 10;

dab_frames = zeros(frame_count_max,dab_mode.Tf);

%frames currently extracted
frame_count = 0;

%% FRAME EXTRACTION
%move into a function eventually
while(1)

    %checking for a prs in symbol
    prs_idx = prs_detect_rad(iq_data,prs,dab_mode)

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









