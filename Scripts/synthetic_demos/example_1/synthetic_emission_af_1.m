% ---------------------------------------------------------------------    
% FERS SIM
% TARGET RANGE: 228 KM
% VELOCITY:     0   M/S
% ---------------------------------------------------------------------  

close all

%file name
hdf5_file_name_emission = "synthetic_emission.h5"

%reading data from hdf5
cmplx_data_emission = loadfersHDF5_iq(hdf5_file_name_emission);

%%
dab_mode = load_dab_rad_constants(3);
%runtime of simulation (seconds)
run_time = 0.5;
%sampling frequency
fs = 20.48e6;
%window skip (time steos)
win_skip = dab_mode.Ts*(dab_mode.L-1)+dab_mode.Tnull;
%pulse repetition frequency
prf = 400;
%the dab mode used


%% AMBIGUITY FUNCTION

T = 1/fs;
fs = f0;
sig_length = length(cmplx_data_emission);
L = dab_mode.L;
Ts = dab_mode.Ts;

ambiguity_function_V4_2(cmplx_data_emission,T,f0,sig_length,1,1000,L,Ts)


%%



















