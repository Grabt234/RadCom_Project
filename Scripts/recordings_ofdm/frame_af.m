% ---------------------------------------------------------------------    
% frame_af: isolates a single DAB frame and generates its ambiguity
%               function
% ---------------------------------------------------------------------  

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

%
dab_frame = dab_frames(1,:);
% sample period
T = 1/fs
% lenght of the frame
tot_time = 1:length(dab_frame);
%center frequency of the signal
fc = 188.928e6
%pulse length scalar in time
pl = length(dab_frame)*T
%number of symbols in frame
L = 76
%"bit" ime (intergration + guard interval)
tb = 2294*T;
ambiguity_function_V4_2(dab_frame,T,fc,pl,0,100,L,tb);

clear all

