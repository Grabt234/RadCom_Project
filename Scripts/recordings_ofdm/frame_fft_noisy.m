% ---------------------------------------------------------------------    
% frame_fft: isolates a single DAB frame and generates a data cube that
%               contains the frequency information per symbol
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

%isolating null symbol
null_symbol = dab_frame(dab_mode.Tg + 1:dab_mode.Tg + dab_mode.Tu-1);
%plotting to confirm all zero as null should be
plot(null_symbol);
title("Null symbol of Frame")
figure



%isolating useful symbols froma DAB frame
dab_symbols = symbols_unpack(dab_frame, dab_mode);
%agles of PRS
prs_angles = angle(dab_symbols(1,:))
zeros_index = find(~prs_angles)
%converting from time fourier domain
dab_symbols = ofdm_demux(dab_symbols);
%making all vals positive
dab_symbols = abs(dab_symbols);

f = 1:1:length(dab_symbols(1,:));
l = 1:1:dab_mode.L;

surf(f,l,10*log(dab_symbols))
title("absolute values FFT applied symbols contained in a DAB frame displayed  cube of ")
xlabel('Sub-carrier index') 
ylabel('Symbol Number L')
zlabel('magnitude in dB')














