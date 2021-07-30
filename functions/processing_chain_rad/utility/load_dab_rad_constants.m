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
        %used
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
        %used
        dab_mode.K         = 20;
        dab_mode.L         = 2;
        dab_mode.Tnull     = 2552;
        dab_mode.Tu        = 2048;
        dab_mode.Tg        = 504;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
        dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                        (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
        dab_mode.p_intra   = 1;
        dab_mode.T_intra   = 0;
        dab_mode.Tf        = (dab_mode.Tp + dab_mode.T_intra)*dab_mode.p_intra;
    elseif (transmission_mode == 3)
        %used in /passsive_processing
        dab_mode.K         = 10;
        dab_mode.L         = 2;
        dab_mode.Tnull     = 0;
        dab_mode.Tu        = 2048;
        dab_mode.Tg        = 504;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
        dab_mode.Tf        = dab_mode.Tnull +(dab_mode.L-1)* dab_mode.Ts;
        dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                        (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
        dab_mode.p_intra   = 10;
        dab_mode.T_intra   = 0;
        dab_mode.Tf        = (dab_mode.Tp + dab_mode.T_intra)*dab_mode.p_intra;
     elseif (transmission_mode == 4)
        %CW wave
        dab_mode.K         = 100;
        dab_mode.L         = 2;
        dab_mode.Tnull     = 0;
        dab_mode.Tu        = 2048;
        dab_mode.Tg        = 504;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
        dab_mode.Tf        = dab_mode.Tnull +(dab_mode.L-1)* dab_mode.Ts;
        dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                        (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
        dab_mode.p_intra   = 1;
        dab_mode.T_intra   = 0;
        dab_mode.Tf        = (dab_mode.Tp + dab_mode.T_intra)*dab_mode.p_intra;
    elseif (transmission_mode == 6)
        %Do not remove, used in /syntheic_demos/ for cw
        dab_mode.K         = 10;
        dab_mode.L         = 2;
        dab_mode.Tnull     = 0;
        dab_mode.Tu        = 2048;
        dab_mode.Tg        = 504;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
        dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                        (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
        dab_mode.p_intra   = 6;
        dab_mode.T_intra   = 0;
        dab_mode.Tf        = (dab_mode.Tp + dab_mode.T_intra)*dab_mode.p_intra;
    elseif (transmission_mode == 7)
        %Do not remove, used in /radcom_processing_demo
        dab_mode.K         = 20;
        dab_mode.L         = 3;
        dab_mode.Tnull     = 0;
        dab_mode.Tu        = 2048;
        dab_mode.Tg        = 504;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
        dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                        (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
        dab_mode.p_intra   = 1;
        dab_mode.T_intra   = 0;
        dab_mode.Tf        = (dab_mode.Tp + dab_mode.T_intra)*dab_mode.p_intra;
    elseif (transmission_mode == 8)
        %used
        dab_mode.K         = 40;
        dab_mode.L         = 2;
        dab_mode.Tnull     = 0;
        dab_mode.Tu        = 2048;
        dab_mode.Tg        = 0;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
        dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                        (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
        dab_mode.p_intra   = 1;
        dab_mode.T_intra   = 0;
        dab_mode.Tf        = (dab_mode.Tp + dab_mode.T_intra)*dab_mode.p_intra;
    elseif (transmission_mode == 9)
        %Do not remove, used in /syntheic_demos/ 
        dab_mode.K         = 20;
        dab_mode.L         = 2;
        dab_mode.Tnull     = 0;
        dab_mode.Tu        = 2048;
        dab_mode.Tg        = 504;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
        dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                        (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
        dab_mode.p_intra   = 1;
        dab_mode.T_intra   = 0;
        dab_mode.Tf        = (dab_mode.Tp + dab_mode.T_intra)*dab_mode.p_intra;
    else
        fprintf("Transmission Mode %d is either invalid or has not yet been implemented.\n", ...
            transmission_mode);
    end
    
end