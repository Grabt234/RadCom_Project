function dab_symbols = symbols_extract(dab_frames, frame_count, dab_mode)
    % ---------------------------------------------------------------------    
    % SYMBOLS_UNPACK: Unpack frame into dab_mode.L x symbols
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > dab_frames:       IQ data of a single DAB frame, with PRS aligned
    %                           [frame_count x dab_mode.Tf]
    %   > frame_count       Number of non zero frames in dab_frames
    %   > dab_mode:         Structure containing constants for DAB mode
    %
    %  Outputs
    %   < dab_symbols:      IQ data in dab_mode.L symbols (i.e. 'chunks')
    %                           [frame_count x dab_mode.L x dab_mode.Ts]
    %
    % ---------------------------------------------------------------------    
    
    % Read symbols from each frame
    dab_symbols = zeros(frame_count, dab_mode.L, dab_mode.Ts);
    
    % Start: Do not remove null or gaurd as these effect radar performance
    % Note: If misaligned _earlier_ is okay, but cannot be later! (Because
    % of cyclic guard interval with cyclic prefix)
    idx = 1;
    
    for l = 1:dab_mode.L % In total, read L symbols
        % Read symbol
        dab_symbols(:,l,:) = dab_frames(:,idx:idx+dab_mode.Ts-1);
        % Jump ahead 1 symbol, incl. guard
        idx = idx + dab_mode.Ts;
    end
    
end