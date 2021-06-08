function [s,s_rows] = gen_all_symbols(t, L , Tu , Ts ,Tg, N, W, A)
    % ---------------------------------------------------------------------    
    % gen_all_symbols: Creates a time domain representation of all the
    %                       symbols contained in a frame
    %                                    
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > t  - Array of time values for which to calculate the sinusoid
    %   > L  - Total OFDM symbols (within the broader frame) 
    %   > Tu - Useful time period(not inlcuding crc)
    %   > Tg - Guard Inverval
    %   > Ts - Symbol time period (Ts + Tg)
    %   > N  - Total number of sub carriers in signal
    %   > W  - Matrix of row vectors containing frequency weights
    %   > A  - Matrix of row vectors containing phase codes
    %  Outputs
    %   > s = Complex envelope of all the symbolbs contained in a frame
    %
    % ---------------------------------------------------------------------
  
    %pre allocating memory
    s = zeros(1, length(t));

    for l = 1:L
        %transposing row of freq and phase weights into column vectors
        w =  W(l,:).';
        a = A(l,:).';
        %(L x t) array where every row is time domain values of a symbol l
        s(l,:) = gen_symbol(t, l-1, Tu, Ts, Tg, N, w, a);
    end
    
    s_rows = s;
    
    s = s';
    s = s(:)';
    
end


















