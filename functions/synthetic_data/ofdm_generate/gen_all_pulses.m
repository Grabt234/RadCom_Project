function S = gen_all_pulses(time,P, L , Tu , Ts ,Tg, N,W_cube,A_cube)
    % ---------------------------------------------------------------------    
    % gen_frame: compiles sigle frames into a "pulse train"
    %                                  
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > t  - Array of time values for which to calculate the sinusoid
    %   > P  - Number of pulses
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
    S = zeros(P, L*length(time));
    
    
    
    for p = 1:P
        
        %extracting frequency weights for current pulse
        W = W_cube(:,:,p);
        
        %extracting phase weights for current pulse
        A = A_cube(p,:,:);
        A = shiftdim(A,1);
        disp(p)
        
        %generating frame
        S(p,:) = gen_pulse(time,L , Tu , Ts ,Tg, N,W,A);
        
    end
    
    %returning matrix(FxL(len(time)) where a row is a pulse
    
    size(S)
end