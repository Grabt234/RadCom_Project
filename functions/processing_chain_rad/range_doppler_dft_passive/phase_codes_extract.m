function phase_codes = phase_codes_extract(dab_frames, frame_count, dab_mode)
    % ---------------------------------------------------------------------    
    % gen_phase_codes: returns a phase code array of the singal
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > dab_frames:  array of frames as complex envelope
    %                       [frame_count x dab_mode.Ts]
    %   > frame-count: number of frames in dab_frames
    %   > dab_mode:    dab mode sructure
    %  Outputs
    %   < dab_carriers: OFDM carriers
    %                       [frame_count x dab_mode.L x dab_mode.Tu]
    %
    % ---------------------------------------------------------------------    
    
    % preallocating memory for all except null symbol
    dab_data = zeros(frame_count, dab_mode.L-1, dab_mode.K);
    
    %% DEMODULATION
    
    for i=1:1:frame_count
    
    % demodulating indiviudual frames
    dab_carriers_remod = demodulate( dab_frames(i,:), frame_count, dab_mode);
    
    % increasing dimension to insert into dab_data
    dab_carriers_remod = shiftdim(dab_carriers_remod, -1);
    
    % storing frame
    dab_data(i,:,:) = dab_carriers_remod;
    
    end

    %% REMODULATION
    
    %memory preallocation
    frame_square = zeros(frame_count, dab_mode.Tf);

    for i=1:1:frame_count


        frame = remodulate(dab_data(i,:,:),dab_mode);

        frame= shiftdim(frame, -1);

        %storing evelopes with null and guard
        frame_square(i,:,:) = frame;

    end

    %% SYMBOL PROCESSING
    
    %cube of symbol envelopes
    frame_cube = symbols_extract(frame_square,frame_count, dab_mode);

    %phase cube as angle
    phase_cube = angle(frame_cube);

    %conversion to unity magnitude
    [x,y] = pol2cart(phase_cube,1);
    phase_codes = x + 1i*y;
    
    
end