dab_mode.K         = 1300;
        dab_mode.L         = 4;
        dab_mode.Tnull     = 0;
        dab_mode.Tu        = 1*2048;
        dab_mode.Tg        = 0;
        dab_mode.Td        = 4*2048;
        dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
        dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
        dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                        (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
        dab_mode.p_intra   = 1;
        dab_mode.T_intra   = 0;
        dab_mode.Tf        = (dab_mode.Tp + dab_mode.T_intra)*dab_mode.p_intra;
        dab_mode.f0        = 2*2.048e6;
        dab_mode.ftx        =2*2.5e6; %6.25e6;