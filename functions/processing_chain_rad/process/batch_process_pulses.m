function [dab_frames, frame_count, iq_data_meas] = ...
        batch_process_pulses(file_name, frame_count_max,dab_mode, fs, type)
    % ---------------------------------------------------------------------    
    % BATCH_PREPROCESS: Utility for ref_builder to extract multiple DAB
    % frames at once, while also returning some other useful info
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > file_name:        Name of hdf5 file (I/value Q/value)
    %   > frame_count_max:  maximum number of frames to be extracted from
    %                       data stream
    %   > dab_mode:         Structure containing constants for DAB mode
    %   > fs:               Sampling frequency of IQ (hdf5) data
    %
    %  Outputs
    %   < frame_cube:       Matrix of DAB frames split into symbols, as
    %                           [frame_count, frame_symbols, symbol_size]
    %   < frame_count:      The number of frames returned
    %   < iq_data_meas:     A copy of the original read in data, without
    %                       being packaged into frames (used as the
    %                       measurement signal)
    %
    % ---------------------------------------------------------------------
    
    %% PRE-ALLOCATION
    dab_frames = zeros(frame_count_max, dab_mode.Tf);

    %% IQ READ
    if (type == 1)
        %check if returns as row or column vector: should be row
        iq_data = loadfersHDF5_cmplx(file_name);
    elseif (type == 2)
            
        iq_data = loadfersHDF5_iq(file_name); 
    end
    
    %% IQ RESAMPLE
    %iq_data = iq_resample(iq_data_raw, fs);
    
    % Return a copy of the measurement signal
    iq_data_meas = iq_data;
    
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
        dab_pulse = pulse_extract_rad(iq_data,prs_idx,0,dab_mode);

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
    
end





















