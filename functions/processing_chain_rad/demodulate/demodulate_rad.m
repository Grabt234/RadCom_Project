function [dab_data, dab_carriers] = demodulate_rad(dab_frame, dab_mode)
    % ---------------------------------------------------------------------    
    % DEMODULATE: 
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > dab_frame:        IQ data of a single DAB frame, with PRS aligned
    %                           [1 x dab_mode.Tf]
    %   > frame_count       Number of frames contained in the data
    %   > dab_mode:         Structure containing constants for DAB mode
    %
    %  Outputs
    %   < dab_data:         Demodulated data of the given DAB frame
    %                           [(dab_mode.L - 1) x dab_mode.K]
    %   
    %  Utility Outputs for ref_builer.m:
    %   < dab_carriers:     Demultiplexed OFDM carriers
    %                           [dab_mode.L x dab_mode.K]
    % ---------------------------------------------------------------------

    %% SYMBOLS UNPACK
    dab_symbols = symbols_unpack_rad(dab_frame, dab_mode);
    
    %% OFDM MUX
    dab_carriers = ofdm_demux(dab_symbols);    
    
    %% DQPSK DEMAP 
    dab_data_raw = dqpsk_demap_rad(dab_carriers, dab_mode);

    %% FREQ DEINTERLEAVE   (Not yet correctly implemented)
%   map = build_interleave_map();
%   dab_data_deinterleaved = freq_deinterleave(dab_data_raw, map);
    dab_data_deinterleaved = dab_data_raw; 
    
    %% DQPSK SNAP
    dab_data_snapped = dqpsk_snap(dab_data_deinterleaved);
    
    
    %% ERROR CORRECTION (Not yet implemented)
    dab_data = error_correct(dab_data_snapped);
    
end