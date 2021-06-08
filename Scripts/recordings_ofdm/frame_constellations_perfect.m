% ---------------------------------------------------------------------    
% frame_constellations_perfect: Plotting PRS phase, symbol 2 phase and the
%                                   demapped symbol 2 phases
% ---------------------------------------------------------------------  

%file name
file_name = "D:\Radar_Recordings\DAB\DAB_7A_188.928.bin"
%type of data stored in files
file_data_type = "double"
%sampling frequency
fs = 2.048e6;
%how many frames are wanted
file_offset = 1e6; %null symbol?
%sampling frequency of data
frame_count = 3;
%unknown atm
%the dab mode used
dab_mode = load_dab_constants(1)

%see function (control d) for description
[dab_frames, ~, ~, ~] = ...
    batch_preprocess(file_name, file_data_type, frame_count, ...
    file_offset, dab_mode,fs);

%isolating a single DAB frame 
dab_frame = dab_frames(1,:);
%isolating useful symbols froma DAB frame
dab_symbols = symbols_unpack(dab_frame, dab_mode);
%converting from time fourier domain
dab_symbols = ofdm_demux(dab_symbols);


%%

%plotting prs
prs = dab_symbols(1,:);
scatter(cos(angle(prs)),sin(angle(prs)));
%labels
xlabel('Real')
ylabel('Imag')
title("Un-adjusted constellation of the prs symbol")
figure

%plotting 1st non prs symbol
symbol = dab_symbols(2,:)
scatter(cos(angle(symbol)),sin(angle(symbol)));
%labels
xlabel('Real')
ylabel('Imag')
title("Un-adjusted constellation of symbol 2")
figure

%plot demapped symbol 2 (first symbol)
symbol(1,dab_mode.mask) = symbol(1,dab_mode.mask)./prs(1,dab_mode.mask);


scatter( real(symbol(dab_mode.mask)) , imag(symbol(dab_mode.mask))  );
%labels
xlabel('Real')
ylabel('Imag')
title("demapped constellation for symbol 2")
%plot limits
xlim([-1 1])
ylim([-1 1])
%%

















