%================================================
% Note that this file is dabMode independant
% Tests conversion of bits to phases
% and then back to bits using pi/4 DQPSK
%================================================

close all
clear all

%% Setting carrier and frame parameter

%Number of frames
F = 2;
%symbols
L = 6;
L_0 = L-1; %excluding prs
%carriers no center
K = 50;    
%carriers incl. center
K_0 = K + 1;
%bits per phase
%only demoing ppi/4 dqpsk
Ns = [2];


for i = 1:length(Ns)
    
    %% Encoding Bits
    
    % Setting bits per phase
    n = Ns(i);
    % Generating bit stream of equal number of ones and zeros
    onez = L_0*K*n;
    zeroz = L_0*K*n;
    bits = [ones(1,onez), zeros(1,zeroz)];
    bits = bits(randperm(numel(bits)));
    bits = num2str(bits,'%i');
    % Defining alphabet mapping
    map = define_alphabet_map(n);
    % Breaking bitstream into n sized strings
    cleaved_bit_stream = cleave_bitstream(bits,n);
    % Converting to phase  
    A = bitstream_to_phase(map,cleaved_bit_stream);
    A = convert_phase_to_complex(A);
    %Reshaping into symbol
    L_encode = convert_vector_symbols(A,K);
    
    
    %% Genrating PRS
    
    %genrating prs
    prs = build_prs_phase_codes(K);
    
    %removing off carrier
    prs_left = prs(1:(length(prs)+1)/2-1);
    prs_right = prs((length(prs)+1)/2+1:end);
    prs = [prs_left prs_right];
    
    %prepending prs
    L_encode = [prs ; L_encode];
    
    %% Compute DPQSK
    
    L_dqpsk = zeros(L,K);
    
    %adding on prs for modulation
    L_dqpsk(1,:) = L_encode(1,:);
    
    %running through all rows wihtout altering prs
    %note: PRS in first position already
    L_dqpsk = convert_symbols_dpsk(L_encode)
    
    figure
    hold on
    colour = [0, 0.4470, 0.7410];
    for j = 1:L
        scatter(j, angle(L_dqpsk(j,:)),'LineWidth',1.5,'MarkerEdgeColor',colour)
    end
    
    yticks([-pi -3/4*pi -pi/2 -pi/4 0 pi/4 pi/2 3/4*pi pi])
    yticklabels({'-\pi','-3\pi/4', '-\pi/2', '-\pi/4','0','-\pi/4', '\pi/2', '3\pi/4' ,'\pi'})
    set(gca,'LineWidth',0.75)
    ax = gca;
    ax.YGrid = 'off';
    ax.XGrid = 'on';
    box on
    xlim padded
    ylim padded
    
    xlabel("Symbol Number", "FontSize", 20)
    ylabel("Phase [rad]", "FontSize", 20)

    %% Decoding bits
    
%     %reshping and tranposing because matlab LOVES column wise
%     phase_codes = reshape(L_encode.',1,[]);
%     
%     %defning an inverse map according the "n"
%     mapper = define_inverse_alphabet_map(n);
%     
%     %converting cmplx number to degree
%     phase_codes = round(wrapTo360(rad2deg(angle(phase_codes))));
%     
%     rx_bits = "";
    
%     for j = 1:length(phase_codes)
%         
%         rx_bits = [rx_bits mapper(phase_codes(j))];
%     end
%     
%     rx_bits
end
    






