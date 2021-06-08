% ---------------------------------------------------------------------    
% frame_constellations_perfect: Plotting PRS phase, symbol 2 phase and the
%                                   demapped symbol 2 phases
% ---------------------------------------------------------------------  

%file name
file_name = "D:\Radar_Recordings\DAB\raw\DAB_data.bin"
%type of data stored in files
file_data_type = "short"
%sampling frequency
fs = 2.5e6;
%how many frames are wanted
file_offset = 0; %null symbol?
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
title("Un-adjusted constellation of the prs symbol (noisy data)")
figure

%plotting 1st non prs symbol
symbol_1 = dab_symbols(2,:);
scatter(cos(angle(symbol_1)),sin(angle(symbol_1)));
%labels
xlabel('Real')
ylabel('Imag')
title("Un-adjusted constellation of symbol 2 (noisy data)")
figure

%plot demapped symbol 2 (first symbol)
symbol_2(1,dab_mode.mask) = symbol_1(1,dab_mode.mask)./prs(1,dab_mode.mask);


scatter( real(symbol_2(dab_mode.mask)) , imag(symbol_2(dab_mode.mask))  );
%labels
xlabel('Real')
ylabel('Imag')
title("demapped unnapped constellation for symbol 2 (noisy data)")
%plot limits
xlim([-1 1])
ylim([-1 1])
figure 

%using actual demapping functions
dab_symbols = dqpsk_demap(dab_symbols,dab_mode);
dab_symbols = dqpsk_snap(dab_symbols);

symbol_3 = dab_symbols(2,:);

scatter( real(symbol_3(dab_mode.mask)) , imag(symbol_3(dab_mode.mask))  );
%labels
xlabel('Real')
ylabel('Imag')
title("demapped snapped constellation for symbol 2 (noisy data)")
%plot limits
xlim([-1 1])
ylim([-1 1])
%%

















