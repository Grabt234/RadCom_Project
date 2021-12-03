%%Notes

%TX file should be generated at the ideal system sampling rate, not what is
%   use in the physiocal hardware
%%
close all
clear all

dab_mode = load_dab_rad_constants(7);

%% RF Parameters
%system sampling rate
fs = 2.048e6;
fc = 2.4e9;
readIn = 1; %s
d = (2048)*4;
tau = dab_mode.Tf;
prt = (d + tau)*1/fs;
prf = 1/prt;
maxPulses = 100;
txFileParams.fs = 2.5e6;
rxFileParams.fs = 2.5e6;

%delay before data starts being taken by hardware
settle = 0.1;
delay = settle + 10*prt*fs;
cableSpeed = 0.6; % as a factor fo the speed of light
c= 299792458*cableSpeed;

%% TX Params Config

%transmitted file parameters
txFilename = "tmp.bin";

%file reading configurations
txFileParams.fileType = 'Bin';
