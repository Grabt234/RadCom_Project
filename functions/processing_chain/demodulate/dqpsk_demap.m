function dab_data_raw = dqpsk_demap(dab_carriers, dab_mode)
    % ---------------------------------------------------------------------    
    % DQPSK_DEMAP: Demap DQPSK data from DAB carriers
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > dab_carriers:     DAB carriers, [dab_mode.L x dab_mode.Tu]
    %   > dab_mode:         Structure containing constants for DAB mode
    %
    %  Outputs
    %   < dab_data_raw:     Extracted DQPSK data, unsnapped,
    %                        [(dab_mode.L - 1) x dab_mode.Tu]
    %
    % ---------------------------------------------------------------------

    % Pre-allocation
    dab_data_raw = zeros(dab_mode.L-1,dab_mode.Tu);
    
    dab_carriers(2,1013:1030)
    % First carrier is phase reference symbol => start at index 2
    for l = 2:dab_mode.L
        % Extract DQPSK by dividing current symbol by previous symbol
        % Note: Use the dab_mode.mask so that only the symbols at the OFDM
        % carrier frequencies are calculated
        % e.g. for mode 1, only the 1536 carriers, not all 2048 bins
         
        dab_data_raw(l-1,dab_mode.mask) = dab_carriers(l,dab_mode.mask) ...
                                        ./ dab_carriers(l-1,dab_mode.mask);
        
        
    end

end