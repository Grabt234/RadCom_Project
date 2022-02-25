%================================================
% Full demod chain demo, outputs bits
% for plots of preprocessing and demod
% see /demod or /preprocessing
%
% Note: null has been manually removed
%================================================

close all
clear all

%% Dab mode used to generate file

dab_mode.K         = 1000;
dab_mode.L         = 5;
dab_mode.Tnull     = 0;
dab_mode.Tu        = 2048;
dab_mode.Tg        = 504;
dab_mode.Td        = 4*2048;
dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
dab_mode.rep       = 5;
dab_mode.Tf        = (dab_mode.Tp + dab_mode.Td)*dab_mode.rep;
dab_mode.f0        = 2.048e6;
dab_mode.ftx       = 2.048e6;

%% Preprocessing and Demod

% Generating PRS
prs = build_prs_custom(dab_mode);

% Loading in data stream
iq_data = loadfersHDF5_iq("data/emission.h5");

% Extracting first pulse/frame
prs_idx = prs_detect_rad(iq_data,prs,dab_mode);

dab_frame = frame_extract_rad(iq_data, prs_idx, dab_mode);

% Demodulation - SYMBOLS UNPACK
dab_symbols = symbols_unpack_rad(dab_frame, dab_mode);

% Demodulation - OFDM MUX
dab_carriers = ofdm_demux(dab_symbols); 

% Demodulation - DQPSK DEMAP 
dab_data_raw = dqpsk_demap_rad(dab_carriers, dab_mode);

% Demodulation - FREQ DEINTERLEAVE   (Not yet implemented)
dab_data_deinterleaved = dab_data_raw; 

% Demodulation - DQPSK SNAP
dab_data_snapped = dqpsk_snap(dab_data_deinterleaved);

% Demodulation - ERROR CORRECTION (Not yet implemented)
dab_data = error_correct(dab_data_snapped);

%% Decoding

%extracting onyl data carrying phases
dab_data = dab_data(:,dab_mode.mask);

%row wise reshape
dab_data = reshape(dab_data.',[],1);

%defning an inverse map according the "n"
mapper = define_inverse_alphabet_map(2);

%converting cmplx number to degree
phase_codes = round(wrapTo360(rad2deg(angle(dab_data))));

rx_bits =  "";

for j = 1:size(phase_codes,1)

    rx_bits = rx_bits + mapper(phase_codes(j)); %this is now a bitstream
end

%% Comparing results

%more compicated than it need to be but works for now
errors = 0;

fileID = fopen('data/bits.txt','r')
ref_bits = fscanf(fileID,'%s')
fclose(fileID);

%splitting into indivudal bits
rx_bits =  split(rx_bits, "");
ref_bits =  split(ref_bits, "");

for k = 1:length(phase_codes)

    if strcmp(rx_bits(k), ref_bits(k))
        %%correct demod so pass
    else
        errors = errors+1; %% incorrect demod
    end

end

errorRate = errors/length(ref_bits)



































