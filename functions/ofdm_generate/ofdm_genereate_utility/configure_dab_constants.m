function custom_dab_mode = configure_dab_constants(K,L,Tnull,Tu,Tg)
    % ---------------------------------------------------------------------    
    %  configure_dab_constants: Allows for custom configuration of a
    %                           a "user defined" DAB standard
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > K - number of sub carriers
    %   > L - number DAB symbols in a frame
    %   > Tnull - Null symbol period
    %   > Tu - useful period of symbol (excluding guard)
    %   > Tg - gaurd interval period
    %
    %  Outputs
    %   > dab_mode:      The relevant custom DAB parameters
    %
    % ---------------------------------------------------------------------
    custom_dab_mode.K         = K;
    custom_dab_mode.L         = L;
    custom_dab_mode.Tnull     = Tnull;
    custom_dab_mode.Tu        = Tu;
    custom_dab_mode.Tg        = Tg;
    custom_dab_mode.Ts        = custom_dab_mode.Tu + custom_dab_mode.Tg;
    custom_dab_mode.Tf        = custom_dab_mode.Tnull + custom_dab_mode.L * custom_dab_mode.Ts;
    custom_dab_mode.mask      = [257:1024,1026:1793]; %cant use mask at the moment. it a mapping to prevent ISI

    
end