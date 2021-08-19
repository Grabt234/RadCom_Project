%% FILE DESCRIPTION
%=================================
% running iq data that was synthetically though (hopefully generalised) 
% DAB processing chain
%=================================

%% LOADING IN INFORMATION

hdf5_file_name = "cw_response_surv.h5"
%hdf5_file_name = "cw_emission_e6.h5"
iq_data = loadfersHDF5_cmplx(hdf5_file_name);
%iq_data = loadfersHDF5_iq(hdf5_file_name);

dab_mode = load_dab_rad_constants(4);

f0 = 2.048e7;

%bits per per code
n = 2;

%% PLOTTING

subplot(2,2,1)
plot((1:1:length(iq_data)),iq_data)
title("RECEIVEd RESPONSE")

%% PRS DETECT

prs = build_prs_custom(dab_mode);

%frames currently extracted
frame_count = 0;
frame_count_max = 1;
%% FRAME EXTRACTION
%move into a function eventually
while(1)

    %checking for a prs in symbol
    prs_idx = prs_detect_rad(iq_data,prs,dab_mode);

    %if run through data and found no prs
    if(prs_idx == -1)
        break
    end

    %%Frame Extraction
    %if prs found, extract frame, frame includes gaurd interval and prs
    dab_pulse = frame_extract_rad(iq_data, prs_idx, dab_mode);
    length(dab_pulse)
    % incrementing number of frames
    frame_count = frame_count + 1;

    %inserting data into data cube
    dab_frames(frame_count,:) = dab_pulse;

    %removing extracted data from data stream
    iq_data = iq_data(prs_idx + dab_mode.Tf - dab_mode.Tnull:end);

    % check if we are at the end if iq_data
    if(length(iq_data) < dab_mode.Tf || frame_count  >= frame_count_max)
        break 
    end

end

%removing zeros
dab_frames = dab_frames(1:frame_count,:,:);

dab_frame = dab_frames(1,:);

%verifying frame extraction
subplot(2,2,2)
plot(1:1:length(dab_frame), dab_frame)
title("DAB frame plot")

%%  PULSE EXTRACTION

%preallocating memory for pulses
dab_pulses = zeros(dab_mode.p_intra, dab_mode.Tp);

%+1 accounts for the array pos starting at 1
pulse_idx = dab_mode.T_intra+1;

%iterating through every pulse WITHIN A COHERENT FRAME
for pulse = 1:dab_mode.p_intra
    
    dab_pulses(pulse,:) = dab_frame(1,pulse_idx :(pulse_idx+dab_mode.Tp-1));
    
    pulse_idx =  pulse_idx + dab_mode.Tp + dab_mode.T_intra;

end

%verifing pulse extraction

subplot(2,2,3)
plot(1:1:length( dab_pulses(1,:)),  dab_pulses(1,:))
title("pulse 1")
subplot(2,2,4)
plot(1:1:length( dab_pulses(2,:)),  dab_pulses(2,:))
title("pulse 2")

%% FFT'ing

pulse_1 = dab_pulses(1,:);

symbol = pulse_1(1:dab_mode.Ts-dab_mode.Tg-1);
SYMBOL  =fftshift(fft(symbol));

figure
subplot(1,3,1)
plot(1:1:length(SYMBOL),abs(SYMBOL))


symbol = pulse_1(1+dab_mode.Tg+dab_mode.Ts:2*dab_mode.Ts);
SYMBOL  =fftshift(fft(symbol));

subplot(1,3,2)
plot(1:1:length(SYMBOL),abs(SYMBOL))

symbol = pulse_1(1+ dab_mode.Tg+2*dab_mode.Ts:3*dab_mode.Ts);
SYMBOL  =fftshift(fft(symbol));

subplot(1,3,3)
plot(1:1:length(SYMBOL),abs(SYMBOL))














