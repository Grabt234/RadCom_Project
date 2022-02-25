function [s,s_rows] = gen_all_symbols(Ts , Tu ,Tg, W, A, L)
    % ---------------------------------------------------------------------    
    % gen_all_symbols: Time domain array of (1 x L*Ts) iq data containing
    %                   L symbols
    %                                    
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > Ts - Symbol Period
    %   > Tu - Integration period
    %   > Tg - Guard Inverval
    %   > K  - OFDM carriers per symbol 
    %   > W  - frequency weight matrix (LxK)
    %   > A  - complex phase matrix (LxK)
    %  Outputs
    %   > s = iq data of frame, array of size (1xL*Ts)
    %   > s_rows = iq data of each symbol in frame, array of size (L x Ts) 
    %
    % ---------------------------------------------------------------------
  
    %pre allocating memory
    s = zeros(1, Ts);
    
    %iterating through each frame symbol
    for l = 1:L
        
        %column vector of frequency weights
        w =  W(l,:).';
        
        %column vector of phase weights
        a = A(l,:).';
        
        %(L x Ts)iq iq data where every row is a single symbol
        s(l,:) = gen_symbol(Ts, Tu, Tg, K, w, a);
    end
    
    %to return array of (L x Ts) symbols
    s_rows = s;
    
    %transposing to concatnate columns as matlab is column first
    % (L x Ts) -> (Ts x L)
    s = s';
    
    %concatenating colums the transposing
    % (Ts x L) -> (Ts*L x 1) -> (1 x Ts*L)
    s = s(:)';
    
end


















