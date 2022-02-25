function frames = generate_frames(N, L, T, Ts, Tu, Tg, Tif, a, d, osf, ...
                                    W_cubes, A_cubes, F_intra, F_inter, T_frame_time)
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
    %   > W_cubes -  frequency weigthing cubes, each to applied to pulses within
    %               frame
    %   > A_cubes -  phase codes cubes, each to be applied to pulses within
    %               frame
    %   >F_intra -  number of intra frame pulses
    %
    % Outputs
    %   > frames  - an array which is the complex envelope of a single frame
    %
    % ---------------------------------------------------------------------
    
    %each frame is as long as the symbols and intera frame times
    frames = zeros(F_inter, T_frame_time*osf);
    
    %time per symbol
    for f = 1:F_inter
        
        W_cube = W_cubes(:,:,:,f);
        A_cube = A_cubes(:,:,:,f);
        
        frames(f,:) = generate_frame(N, L, T, Ts, Tu, Tg, Tif, a, d, osf, ...
                                    W_cube, A_cube, F_intra);
    end
    
  
end