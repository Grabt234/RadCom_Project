function A_cube = gen_rand_frame_phase_weights_cube(L, N, F_intra)
    % ---------------------------------------------------------------------    
    % gen_rand_frame_phase_weight_cube: generates an array of complex time
    %                     domain sinusoid values according to dab 
    %                       params (incl CRC)    
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > L  - number of symbols in a frame
    %   > N  - Number of subcarriers in a frame
    %   > F_intra  - number of pulses in a OFDM pulse train
    %  Outputs
    %   > W_cube of (LxN) x F sets of of pulse frequency weights
    %
    % ---------------------------------------------------------------------
    
    A_cube = zeros(L,N,F_intra);
    
    for f = 1:F_intra
        
        A_cube(:,:,f) = gen_rand_phase_weights(L,N);
        
    end
    
   
end