function adjusted_frames = phase_code_correct(dab_frames, phase_cube, ...
                                                    frame_count, dab_mode)
    % ---------------------------------------------------------------------    
    % phase_code_correct: applies phase code correction to the recieved
    %                       data so only doppler phasing remains
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > dab_frame_cube:   frequency domain symbols extracted from frame
    %                       [frame_count x dab_mode.L x dab_mode.Ts]
    %   > phase_codes_cube: unity magnitude complex numbers conatiaining
    %                       original signal phase codes
    %  Outputs
    %   < corrected_cube:   
    %
    % ---------------------------------------------------------------------    
   
    %preallocation
    adjusted_frames = zeros(frame_count, dab_mode.Ts);
    
    for i=1:frame_count

        adjusted_frame = squeeze(dab_frames(1,:,:)).'*squeeze(phase_cube(i,:,:));

        adjusted_frames(i,:) = diag(adjusted_frame).';
    end

end