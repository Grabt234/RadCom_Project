function frame = generate_frame(N, L, T, Ts, Tu, Tg, Tif, a, d, osf, ...
                                    W_cube, A_cube, F_intra)
    % ---------------------------------------------------------------------    
    % generate_frame: creates a frame which is comprised of multiple pulses
    %                   and intra pulse periods
    %                   
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > N   - number of data carrying carriers (N_0-1)
    %   > L   - number of symbols per intra frame pulse
    %   > T   - elemetary period
    %   > Ts  - symbol period (integer multiples of elementary)
    %   > Tu  - integration period (integer multiples of elementary)
    %   > Tg  - gaurd interval (integer multiples of elementary)
    %   > Tif - intra frame period, time between pulses within frame 
    %                (integer multiples of elementary)
    %   > a   - Number elementary periods in symbol period
    %   > d   - Number elementary periods in intraframe period
    %   > W_cube -  frequency weigthing cube to applied to pulses within
    %               frame
    %   > A_cube -  phase codes cube to applied to pulses within
    %               frame
    %   >F_intra -  number of intra frame pulses
    %
    % Outputs
    %   > frame  - an array which is the complex envelope of a single frame
    %
    % ---------------------------------------------------------------------
    
    %time per symbol
    symbol_time = linspace(T,Ts,a*osf);

    %generating all envelopes of frames
    S = gen_all_pulses(symbol_time, F_intra, L, Tu, Ts, Tg, N,W_cube,A_cube);

    %intra_frame time
    tif_time = linspace(T,Tif,d*osf);

    %adding in interframe time periods
    S = insert_intra_frame_time(S, F_intra, tif_time);

    %converting rows to columns
    S = S';
    
    %stacking all columns the transposing
    frame = S(:)';

end