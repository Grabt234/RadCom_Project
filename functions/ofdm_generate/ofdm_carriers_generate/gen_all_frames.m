function s = gen_all_frames(Ts, Tu, Tg, W_cube, A_cube, L, F)
    % ---------------------------------------------------------------------    
    % gen_frame: compiles sigle frames into a "pulse train"
    %                                  
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > Ts - Symbol Period
    %   > Tu - Integration period
    %   > Tg - Guard Inverval
    %   > K  - OFDM carriers per symbol 
    %   > W  - frequency weight matrix (F x L x K)
    %   > A  - complex phase matrix (F x L x K)
    %   > F  - Number of frames to generate
    %  Outputs
    %   > s  - retrun (F X L*Ts) matrix of frames
    %
    % ---------------------------------------------------------------------
    
    %pre allocating frame matrix
    s = zeros(F, L*Ts);
    
    %generating all frames
    for f = 1:F
        
        %extracting frequency weights for current pulse
        W = W_cube(f,:,:);
        %compressing into (L x K) matrix
        % (F x L x K) -> (L x K)
        W = shiftdim(W,1);

        %extracting phase weights for current pulse
        A = A_cube(f,:,:);
        %compressing into (L x K) matrix
        % (F x L x K) -> (L x K)
        A = shiftdim(A,1);

        %generating frame iq data
        s(f,:) = gen_frame(Ts, Tu, Tg, W, A, L);
        
    end
    

end