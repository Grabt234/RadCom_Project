function S_0 = gen_center_frequency(T,signal_time)
    % ---------------------------------------------------------------------    
    % gen_center_frequency: generates the center frequency as per the DAB
    %                           main signal defenition                                    
    %
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > f - center frequency
    %  Outputs
    %   > s_0 = Sinusoid of center frequency
    %
    % ---------------------------------------------------------------------

    %generating carrier/center to be applied to whole signal
    S_0 =  exp((2*pi*1i*signal_time)/T);
    
end