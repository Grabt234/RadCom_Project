function S = gen_all_pulses(time,F, L , Tu , Ts ,Tg, N,W_cube,A_cube)
    % ---------------------------------------------------------------------    
    % gen_frame: compiles sigle frames into a "pulse train"
    %                                  
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > t  - Array of time values for which to calculate the sinusoid
    %   > F  - Number of frames
    %   > L  - Total OFDM symbols (within a broader frame) 
    %   > Tu - Useful time period(not inlcuding crc)
    %   > Tg - Guard Inverval
    %   > Ts - Symbol time period (Ts + Tg)
    %   > N  - Total number of sub carriers in signal
    %   > W_cube  - a cube of (LxN)xF frequency weights
    %   > A  - Matrix of row vectors containing phase codes
    %  Outputs
    %   > S = Matrix where rows correspond to compelx envelope of frame
    %
    % ---------------------------------------------------------------------
    
    %pre allocating memory for time domain
    %will create (pulses X pulse length)
    S = zeros(F, L*length(time));
    
    
    
    for f = 1:F
        
        %extracting frequency weights for current frame
        W = W_cube(:,:,f);
        
        %extracting frequency weights for current frame
        A = A_cube(:,:,f);
        
        %generating frame
        S(f,:) = gen_pulse(time,L , Tu , Ts ,Tg, N,W,A);
        
    end
    
    %returning matrix(FxL(len(time)) where a row is a pulse
    

end