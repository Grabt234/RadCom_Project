% ---------------------------------------------------------------------    
% create_fers_pulse_dab: isolates a single frame from a standard DAB 
%                    recording and saves as an hdf file which can be 
%                    used in fers
% ---------------------------------------------------------------------  

%%  EXTRACTING FRAME

%file name
file_name = "D:\Radar_Recordings\DAB\DAB_7A_188.928.bin"
%type of data stored in files
file_data_type = "double"
%sampling frequency
fs = 2.048e6
%how many frames are wanted
file_offset = 1e6; %null symbol?
%sampling frequency of data
frame_count = 3
%unknown atm
%the dab mode used
dab_mode = load_dab_constants(1)

%see function (control d) for description
[dab_frames, ~, ~, ~] = ...
    batch_preprocess(file_name, file_data_type, frame_count, ...
    file_offset, dab_mode,fs);

%isolating a single dab frame
dab_frame = dab_frames(1,:);

%% PLOTTING FRAME

plot( (1:size(dab_frame,2))*1/fs, dab_frame);
title('Plot of single DAB frame')
xlabel("time in seconds")
ylabel("voltage")

%% ISOLATING N SYMBOLS
%including guard interval

% special case: confiured toe extract integration period of prs, 1ms
number_symbols = 1;
begin_cut   = dab_mode.Tnull + dab_mode.Tg
end_cut     = dab_mode.Tnull + dab_mode.Ts*number_symbols;

%extracting symbols to form new pulse
dab_symbols = dab_frame(begin_cut:end_cut);

%% PLOTTING RADAR PULSE

plot( (1:size(dab_symbols,2))*1/fs, dab_symbols);
title('Plot of N extracted symbols used for Radar')
xlabel("time in seconds")
ylabel("voltage")


%% STORING FRAME

%pulse name
name = "pulse_dab_symbols"

%file name
file_name = name + ".h5"

%hdf5 heirarchy
hdf5_heirarchy = "/" + name

I = real(dab_symbols);
Q = imag(dab_symbols);


h5create(file_name,'/I/value',length(I));
h5create(file_name,'/Q/value',length(Q));

%writing hdf5 dataset
h5write(file_name,'/I/value',I);
h5write(file_name,'/Q/value',Q);














