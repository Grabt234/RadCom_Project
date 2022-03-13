function dab_data_deinterleaved = freq_deinterleave(dab_data_raw, dab_mode)
    % ---------------------------------------------------------------------    
    % FREQ_DEINTERLEAVE: Deinterleave OFDM components for each symbol
    % within a DAB frame
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > dab_data_raw:             Raw DQPSK data,
    %                                   [(dab_mode.L - 1) x dab_mode.Tu]
    %   > dab_mode
    %
    %  Outputs
    %   < dab_data_deinterleaved:   Deinterleaved DQPSK data
    %                                   [dab_mode.L x dab_mode.K]
    %
    % ---------------------------------------------------------------------
    
    %just extracting active carriers
    dab_data_deinterleaved = dab_data_raw(:, ...
                dab_mode.Tu/2 - dab_mode.K/2:dab_mode.Tu/2 + dab_mode.K/2);
end