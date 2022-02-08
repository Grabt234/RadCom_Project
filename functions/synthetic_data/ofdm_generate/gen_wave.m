function [S, bits, S_single] = gen_wave(dab_mode)
    
    %bits per phase
    n = 2;

    %% EXTRACTING DAB_CONSTANTS

    %symbols
    L = dab_mode.L;
    L_0 = L;
    %carriers no center
    K = dab_mode.K ;    
    %carriers incl. center
    K_0 = dab_mode.K + 1;
    %integration period
    Tu = dab_mode.Tu;
    %symbol period
    Ts = dab_mode.Ts;
    %gaurd inteval
    Tg = dab_mode.Tg;
    %delay samples
    Td = dab_mode.Td;

    %% Generating Bit stream
    
    %even proportion of 1's and zeros
    onez = ((L-2)*K)*2/2;
    zeroz = ((L-2)*K)*2/2;
    bits = [ones(1,onez), zeros(1,zeroz)];
    bits = bits(randperm(numel(bits)));
    bits = num2str(bits,'%i');
    
    %% ENCODING BITS
    
    [F, A_pulses] = bits_to_phase_cube(bits,n,dab_mode);

    %Frequency weights 
    W_cube = ones(F,L_0,K_0);
    W_cube = rescale_cube_to_unity_weights(W_cube,F);

    symbol_time = 1:1:Ts;

    %% GENERATING WAVEFORM

    %generating all envelopes of framestx = tx(1:4096);
    S = gen_all_pulses(symbol_time, F, L_0, Tu, Ts, Tg, K,W_cube,A_pulses);

    %% PLOTTING

    %converting rows to columns
    S = S';
    %stacking all columns the transposing
    S = S(:)';

    S = [S zeros(1,Td)];

    S_single = S;

    %repeating to multiple pulses
    S = repmat(S,[1,dab_mode.rep]);

  
end