function W_cube = gen_rand_freq_weights_cube(L, N, F)
    % ---------------------------------------------------------------------    
    % gen_rand_pulse_weights: generates an array of complex time domain
    %                    sinusoid values according to dab params (incl CRC)
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > L  - number of symbols in a frame
    %   > N  - Number of subcarriers in a frame
    %   > F  - number of pulses in a OFDM pulse train
    %  Outputs
    %   > W_cube of ((L x N) x F) sets of of pulse frequency weights
    %
    % ---------------------------------------------------------------------
    
    W_cube = zeros(L,N,F);
    
    for f = 1:F
        
        W_cube(:,:,f) = gen_rand_freq_weights(L,N);
        
    end
   
end
