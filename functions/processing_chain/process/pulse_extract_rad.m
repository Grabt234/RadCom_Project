function dab_pulse = pulse_extract_rad(iq_data, prs_index, frame_offset, dab_mode)
    % ---------------------------------------------------------------------    
    % pulse_extract_rad: Extract a single pulse from given DAB_RAD frame
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > iq_data:      IQ data correctly sampled at Fs = 2.048e6
    %   > prs_index:	Index of first phase reference symbol
    %   > frame_offset:	Frame offset from first phase reference symbol
    %   > dab_mode:     Structure containing constants for DAB mode
    %
    %  Outputs
    %   < dab_pulse:    IQ data of a single DAB_RAD pulse
    %
    % ---------------------------------------------------------------------
    
    % Extracted frame should include PRS' guard interval, & the null symbol
    start_idx = prs_index - dab_mode.Tg - dab_mode.Tnull + frame_offset*dab_mode.Tf

    % If gone too far back, pad the front of the returned frame with zeros
    if (start_idx < 1)
        % start_idx is negative, so (1-start_idx) is positive
        dab_pulse = zeros(1,1 - start_idx);
        dab_pulse = [dab_pulse  iq_data(1:dab_mode.Tf+start_idx-1)];
    else
        % Otherwise simply extract the frame
        dab_pulse = iq_data(start_idx:start_idx+dab_mode.Tf-1);
    end

end