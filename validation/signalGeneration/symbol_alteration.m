%================================================
% Note that this file is dabMode independant
% Tests the alteration of the symbol count
%================================================

Ls = [2,5,8,10];
dab_mode = load_dab_rad_constants(3);

for i = 1:length(Ls)
    
    %symbols
    L = Ls(i);
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
    %intra frame time: spacing between pulses within a frame
    T_intra = dab_mode.T_intra;

    %Manually setting frame count
    F = 1;
    
    %% ENCODING BITS
    
    A_pulses = ones(F,L_0,K_0);

    %Frequency weights 
    W_cube = ones(F,L_0,K_0);
    W_cube = rescale_cube_to_unity_weights(W_cube,F);

    symbol_time = 1:1:Ts;
    
    %% GENERATING WAVEFORM

    %generating all envelopes of framestx = tx(1:4096);
    S = gen_all_pulses(symbol_time, F, L_0, Tu, Ts, Tg, K,W_cube,A_pulses);

%% plotting

    
    
     S = reshape(S,2048,[]);
     S = fftshift(fft(S,[],1));
     subplot(2,2,i)
     S = S.';
     S = S./max(S,[],"all");
        h = surf(((1:1:size(S,2)) - size(S,2)/2)/size(S,2)*2.048,1:1:size(S,1),abs(S));
        colour = [0, 0.4470, 0.7410];
        colormap 'white'; 
        h.FaceLighting = 'flat';
        h.EdgeAlpha = 1;
        h.EdgeColor = colour;
        h.EdgeLighting = 'gouraud';
        xlabel("Frequency [MHz]",'FontSize',15);
        ylabel("Symbol Index [L]",'FontSize',15);
        zlabel("Magnitude [arb]",'FontSize',15);
        xlim tight
        ylim tight
        if L == 2
          yticks([1 2])
        end
    

end






