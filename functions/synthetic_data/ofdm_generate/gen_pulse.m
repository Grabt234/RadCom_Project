function f = gen_pulse(time,L , Tu , Ts ,Tg, N,W,a)
    % ---------------------------------------------------------------------    
    % gen_frame: compiles symbols into a sigle pulse
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
    %   > f = Complex envelope of the frame
    %
    % ---------------------------------------------------------------------
    
    %compiles all symbols into a single continous frame
    
    [f,~]= gen_all_symbols(time,L , Tu , Ts ,Tg, N,W,a);
    

end