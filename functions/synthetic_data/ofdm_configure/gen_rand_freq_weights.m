function w = gen_rand_freq_weights(L, N)
    % ---------------------------------------------------------------------    
    % gen_rand_freq_weights: generate frequency weights that are 
    %                           uniformly distributed from 0-1
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > L - Number of symbols to generate wieghts for
    %   > N - Number of sub carriers that need to modulated in each symbol
    %  Outputs
    %   > w - randomized set of frequency weights between 2 user defined
    %           values
    %
    % ---------------------------------------------------------------------
   
   %pre allocating memory
   w = rand(L,N);

end