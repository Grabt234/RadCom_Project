% ---------------------------------------------------------------------    
% create_fers_pulse_dab: isolates a single frame from a dab recording and
%                           saves as an hdf file to be used in fers
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

%isolating a single bad frame
dab_frame = dab_frames(1,:);

%pulse name
name = "pulse_dab"

%file name
file_name = name + ".h5"

%hdf5 heirarchy
hdf5_heirarchy = "/" + name

I = real(dab_frame);
Q = imag(dab_frame);


h5create(file_name,'/I/value',length(I));
h5create(file_name,'/Q/value',length(Q));

%writing hdf5 dataset
h5write(file_name,'/I/value',I);
h5write(file_name,'/Q/value',Q);














