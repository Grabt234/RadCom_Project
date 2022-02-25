function A = gen_rand_phase_weights(L, N)
    % ---------------------------------------------------------------------    
    % gen_rand_phase_weights: generate phase weights that are 
    %                           uniformly distributed for quadrature
    %                           multplexing
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > L - Number of symbols to generate wieghts for
    %   > N - Number of sub carriers that need to modulated in each symbol
    %  Outputs
    %   > A - randomized matrix of frequency weights between 2 user defined
    %           values
    %
    % ---------------------------------------------------------------------
   
   %pre allocating memory

   angle = pi/4 + (2*pi/4)*unidrnd(4,L,N);
   A = cos(angle) +1i*sin(angle);

   
   center_carrier = ((N-1)/2) + 1;
   A(:,center_carrier) = zeros(L,1);
  
end