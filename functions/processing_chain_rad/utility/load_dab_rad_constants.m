function dab_mode = load_dab_rad_constants(transmission_mode)
    % ---------------------------------------------------------------------    
    % LOAD_DAB_CONSTANTS: Return the paramters for a DAB mode
    %                           (currently for Mode 1 only)
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > transmission_mode:    The DAB transmission mode
    %
    %  Outputs
    %   > dab_mode:      The relevant parameters
    %
    % ---------------------------------------------------------------------
    if (transmission_mode == 1)
        dab_mode.K         = 1536;
        dab_mode.L         = 76;
        dab_mode.Tnull     = 2656;
        dab_mode.Tu        = 2048;
        dab_mode.Tg        = 504;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tf        = dab_mode.Tnull + dab_mode.L * dab_mode.Ts;
        dab_mode.mask      = [257:1024,1026:1793];
        dab_mode.F_intra   = 1;
        dab_mode.T_intra   = 0;
        
    elseif (transmission_mode == 2)
        dab_mode.K         = 20;
        dab_mode.L         = 3;
        dab_mode.Tnull     = 2656;
        dab_mode.Tu        = 2048;
        dab_mode.Tg        = 504;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tf        = dab_mode.Tnull + dab_mode.L * dab_mode.Ts;
        dab_mode.mask      = [dab_mode.Tu/2-dab_mode.K/2 -1:dab_mode.Tu/2,...
                                    dab_mode.Tu/2 + 2:dab_mode.Tu/2+2 +dab_mode.K/2 -1];
        dab_mode.F_intra   = 1;
        dab_mode.T_intra   = 0;
        
    elseif (transmission_mode == 3)
        %no defined fc
        dab_mode.K         = 50;
        dab_mode.L         = 2;
        dab_mode.Tnull     = 2656;
        dab_mode.Tu        = 2048;
        dab_mode.Tg        = 504;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tf        = dab_mode.Tnull + dab_mode.L * dab_mode.Ts;
        dab_mode.mask      = [dab_mode.Tu/2-dab_mode.K/2 -1:dab_mode.Tu/2,...
                                    dab_mode.Tu/2 + 2:dab_mode.Tu/2+2 +dab_mode.K/2 -1];
        dab_mode.F_intra   = 1;
        dab_mode.T_intra   = 0;
    elseif (transmission_mode == 4)
        %no defined fc
        dab_mode.K         = 100;
        dab_mode.L         = 3;
        dab_mode.Tnull     = 26560;
        dab_mode.Tu        = 20480;
        dab_mode.Tg        = 5040;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tf        = dab_mode.Tnull + dab_mode.L * dab_mode.Ts;
        dab_mode.mask      = [dab_mode.Tu/2-dab_mode.K/2 -1:dab_mode.Tu/2,...
                                    dab_mode.Tu/2 + 2:dab_mode.Tu/2+2 +dab_mode.K/2 -1];
        dab_mode.F_intra   = 1;
        dab_mode.T_intra   = 0;
    elseif (transmission_mode == 5)
        %no defined fc
        dab_mode.K         = 20;
        dab_mode.L         = 2;
        dab_mode.Tnull     = 26560*0.4;
        dab_mode.Tu        = 20480*0.4;
        dab_mode.Tg        = 5040*0.4;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tf        = dab_mode.Tnull + dab_mode.L * dab_mode.Ts;
        dab_mode.mask      = [dab_mode.Tu/2-dab_mode.K/2 -1:dab_mode.Tu/2,...
                                    dab_mode.Tu/2 + 2:dab_mode.Tu/2+2 +dab_mode.K/2 -1];
        dab_mode.F_intra   = 1;
        dab_mode.T_intra   = 0;
    elseif (transmission_mode == 6)
        %no defined fc
        dab_mode.K         = 20;
        dab_mode.L         = 2;
        dab_mode.Tnull     = 26560*0.6;
        dab_mode.Tu        = 20480*0.6;
        dab_mode.Tg        = 5040*0.6;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tf        = dab_mode.Tnull + dab_mode.L * dab_mode.Ts;
        dab_mode.mask      = [dab_mode.Tu/2-dab_mode.K/2 -1:dab_mode.Tu/2,...
                                    dab_mode.Tu/2 + 2:dab_mode.Tu/2+2 +dab_mode.K/2 -1];
        dab_mode.F_intra   = 1;
        dab_mode.T_intra   = 0;
    else
        fprintf("Transmission Mode %d is either invalid or has not yet been implemented.\n", ...
            transmission_mode);
    end
    
end