function A_cubes = gen_rand_frame_phase_weights_cubes(L, N, F_intra, F_inter)
    % ---------------------------------------------------------------------    
    % gen_rand_frame_phase_weights_cubes: generates multiple frame cubes
    %                               that are random phase weightingings
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > L  - number of symbols in a frame
    %   > N  - Number of subcarriers in a frame
    %   > F_intra  - number of pulses in a single frame
    %   > F_inter  - number of frames is a given pulse train
    %  Outputs
    %   > W_cubes of ((LxN) x F_intra) x F_inter cubes of frame phase
    %                               weigths
    %
    % ---------------------------------------------------------------------
    
    A_cubes = zeros( L, N, F_intra, F_inter);
    
    for f = 1:F_inter
        
        A_cubes(:,:,:,f) = gen_rand_frame_phase_weights_cube(L,N,F_intra);
        
    end
    
   
end