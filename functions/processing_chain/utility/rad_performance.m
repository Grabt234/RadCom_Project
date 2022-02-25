function rad_performance(mode, f0)
    % ---------------------------------------------------------------------    
    % build_matched_filter: creates matched filter using a given reference
    %                               signal
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > h:        The reference signal
    %
    %  Outputs
    %   > H:        matched filter coefficients
    %
    % ---------------------------------------------------------------------
    
    dab_mode = load_dab_rad_constants(mode)
    
    %elementary period
    T = 1/f0
    
    %symbol length
    symbol_length = dab_mode.Ts*T
    
    %pulse length (including prs)
    pulse_length = symbol_length*dab_mode.L + dab_mode.Tnull*T
    
    %intra pulse time
    intra_pulse_time = dab_mode.T_intra*T
    
    %time between pulses
    intra_frame_PRI = pulse_length+ intra_pulse_time   
    
    %frequency of pulses
    intra_frame_PRF = 1/intra_frame_PRI
    
    %time it takes to transmit frame
    %if transmitting immediatley after one another
    frame_PRI = intra_frame_PRI*dab_mode.F_intra
    
    frame_prf = 1/frame_PRI
    
    
end