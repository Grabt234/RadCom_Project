function dab_data_raw = dqpsk_demap_rad(dab_carriers, dab_mode)
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

    %number of symbols in each frame  (prs removed)
    frame_symbols = dab_mode.L-2;
    
    %preallocation of memeory
    dab_data_raw = zeros(frame_symbols,dab_mode.Tu);

    % First carrier is phase reference symbol => start at index 2
    % +1 required to demod last smymbol while accoutning for prs
    for l = 2:frame_symbols+1
        % Extract DQPSK by dividing current symbol by previous symbol
        % Note: Use the dab_mode.mask so that only the symbols at the OFDM
        % carrier frequencies are calculated
        % e.g. for mode 1, only the 1536 carriers, not all 2048 bins
      
        dab_data_raw(l-1,dab_mode.mask) = dab_carriers(l,dab_mode.mask) ...
                                        ./ dab_carriers(l-1,dab_mode.mask);                              
    
    end
    
    

end