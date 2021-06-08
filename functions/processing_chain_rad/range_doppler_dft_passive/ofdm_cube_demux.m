function dab_carriers = ofdm__cube_demux(dab_symbols)
    % ---------------------------------------------------------------------    
    % OFDM_DEMUX: Demultiplex OFDM symbols into DAB carriers using FFT
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > dab_symbols:  Symbols extracted from frame
    %                       [frame_count x dab_mode.L x dab_mode.Tu]
    %  Outputs
    %   < dab_carriers: OFDM carriers
    %                       [frame_count x dab_mode.L x dab_mode.Tu]
    %
    % ---------------------------------------------------------------------    
    % Extract symbols using FFT with no rescaling
    dab_carriers = fftshift(fft(dab_symbols,[],3),3);
end