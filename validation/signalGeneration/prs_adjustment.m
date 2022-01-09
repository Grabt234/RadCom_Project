%================================================
% Note that this file is dabMode independant
% Tests the alteration of the PRS symbol
%================================================

clear all 
close all

%% WAVEFORM PARAMETERS

f0 = 2.048e6;
T = 1/f0;

%% Setting Test Parameters

Ks = [250 500 750 1536];

prs_ref = build_prs(1);
prs_ref = ifft(prs_ref);

for i = 1: length(Ks)
    
    %slecting carrier
    K = Ks(i);
    
    %buiilding custom phase code
    prs = build_prs_phase_codes(K);
    
    %extracts phase codes independantly of carriers
    % therefore pre and postpend additional carriers
    % in frequency domain
    PRS = [zeros(1,(2048 - K)/2) prs zeros(1, (2048 - K)/2 -1)];
    
    %converting to time domain
    prs = ifft(PRS);
    
    %adding guard interval back in
    prs = [ prs(1,2048:end) prs ];
   
    %% Plotting
    
    subplot(2,2,i)
    hold on
    plot((1:1:length(prs))*1/f0, real(prs));
    p = plot( (1:1:length(prs_ref))*1/f0, real(prs_ref), "Color", "b");
    p.Color(4) = 0.1;
    hold off
    xlim tight
    ylim padded
    xlabel("Time [s]", "FontSize", 15)
    ylabel("Magnitude [Linear]", "FontSize", 15)

end


