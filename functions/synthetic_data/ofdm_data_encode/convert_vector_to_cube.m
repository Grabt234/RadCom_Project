function [F,A_cube] = convert_vector_to_cube(A,L,N)
    % ---------------------------------------------------------------------    
    % convert_vector_to_cube: Will take in an array of phase codes and 
    %                              return a variable number of frames
    %                              dependant on data length. also adds in 
    %                              a prs in the first position
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > A - vector of phase codes
    %  > L - number of symbols in a frame
    %  > N - Number of subcarriers in a symbol
    %
    %  Outputs
    %  > A_cube - phase code cube for F frames of shape ( (L x N) x F)
    %
    % ---------------------------------------------------------------------
   
   %number of frames required (phase codes per frame = LxN)
   %second term for non integer frame counts
   remainder = mod(length(A),L*N);
   F = (length(A) - remainder)/(L*N) + ceil( remainder/(L*N) );
   
   size_filler = F*N*L - length(A);
   fill = ones(size_filler,1);
   
   prs = build_prs_custom(L);
   %appending ones to make integer multiple of frame
   A = [A ; fill];
   
   A_cube = reshape(A, [L,N,F]);
   
end