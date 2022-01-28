%================================================
% Note that this file is dabMode independant
% Tests conversion of bits to phases
% and then back to bits using pi/4 DQPSK
%   -> Ignores central carrier - relevant for
%                                   mask
%================================================

close all
clear all

%% Setting carrier and frame parameter

%Number of frames
F = 1;
%symbols
L = 5;
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
    onez = L_0*K*n/2; %50 50 plit between 1's and zeros
    zeroz = L_0*K*n/2;
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
    
    %normally used to accoutn for unised carriers in Tu
    dab_mode.mask = [1:K];
    %normally this is tu long and has the mask removing the guard frequency space
    dab_mode.Tu = K; 
    %not including null
    dab_mode.L = L;
    
    %% Genrating PRS
    
    %genrating prs
    prs = build_prs_phase_codes(K);
    
    %removing off carrier
    prs_left = prs(1:(length(prs)+1)/2-1);
    prs_right = prs((length(prs)+1)/2+1:end);
    prs = [prs_left prs_right];
    
    %prepending prs
    L_encode = [prs ; L_encode];
    
    %% ENCODE - Compute DPQSK
    
    L_dqpsk = zeros(L,K);
    
    %adding on prs for modulation
    L_dqpsk(1,:) = L_encode(1,:);
    
    %running through all rows wihtout altering prs
    %note: PRS in first position already
    L_dqpsk = convert_symbols_dpsk(L_encode); 

    %% Decoding bits
    
    %demapping from dqpsk
    L_decode = dqpsk_demap(L_dqpsk,dab_mode);
    
    %row wise reshape
    L_decode = reshape(L_decode.',[],1);
    
    %defning an inverse map according the "n"
    mapper = define_inverse_alphabet_map(Ns);
    
    %converting cmplx number to degree
    phase_codes = round(wrapTo360(rad2deg(angle(L_decode))));

    rx_bits =  "";
    
    for j = 1:size(phase_codes,1)
        
        rx_bits = rx_bits + mapper(phase_codes(j)); %this is now a bitstream
    end
    
    %% Comparing results
    
    %more compicated than it need to be but works for now
    errors = 0;
    
    %splitting into indivudal bits
    rx_bits =  split(rx_bits, "");
    bits =  split(bits, "");
    
    for k = 1:length(phase_codes)
      
        if strcmp(rx_bits(k), bits(k))
            %%correct demod so pass
        else
            errors = errors+1; %% incorrect demod
        end
        
    end
    
    errorRate = errors/length(bits)
        
end
    






