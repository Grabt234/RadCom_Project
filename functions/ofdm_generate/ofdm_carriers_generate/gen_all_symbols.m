function [s,s_rows] = gen_all_symbols(L , Tu , Ts ,Tg, W, A)
    % ---------------------------------------------------------------------    
    % gen_all_symbols: Creates a time domain representation of all the
    %                       symbols contained in a frame
    %                                    
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > Ts - Symbol Period
    %   > Tu - Integration period
    %   > Tg - Guard Inverval
    %   > K  - OFDM carriers per symbol ()
    %   > W  - frequency weight vector (1xK)
    %   > A  - complex phase value (1xK)
    %  Outputs
    %   > s = Complex envelope of all the symbolbs contained in a frame
    %
    % ---------------------------------------------------------------------
  
    %pre allocating memory
    s = zeros(1, Ts);

    for l = 1:L
        %transposing row of freq and phase weights into column vectors
        w =  W(l,:).';
        a = A(l,:).';
        
        %(L x t) array where every row is time domain values of a symbol l
        s(l,:) = gen_symbol(Ts, Tu, Tg, K, w, a);
    end
    
    s_rows = s;
    
    s = s';
    s = s(:)';
    
end


















