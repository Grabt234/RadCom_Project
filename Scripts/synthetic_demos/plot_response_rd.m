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
txFileParams.dataType = "double";


%% RX Params Config

%transmitted file parameters
rxFilename = "rx.dat";

%file reading configurations
rxFileParams.fileType = 'Bin';
rxFileParams.dataType = "double";

%% TX Read In/Resample

txFileParams.r_fid = fopen(txFilename,'rb');

%reading in doubles from bin file
tx_file = fread(txFileParams.r_fid, txFileParams.dataType);

%changing into complex numbers
tx = tx_file(1:2:end) + 1j*tx_file(2:2:end);

%changing column into row
tx = tx.';

figure
%Plotting time domain of tx signal
subplot(2,2,1)
ax = (1:1:length(tx))*1/txFileParams.fs;
plot(ax, real(tx))
xlabel("time - s")
ylabel("amplitude")
title("TIME DOMAIN OF TX SIGNAL")

%Plotting Tx Frequency Domain
subplot(2,2,2)
ax = (1:1:length(tx))*txFileParams.fs/length(tx) - txFileParams.fs/2;
plot(ax/1e6, 20*log10(abs(fftshift(fft(tx)))))
xlabel("frequency - Mhz")
ylabel("amplitude")
title("FREQUENCY DOMAIN OF TX SIGNAL")

%resampling to system frequency
tx = resample(tx, fs, txFileParams.fs);

% tx = tx(1, 1:dab_mode.Tf);
%% RX read in/Resample

rxFileParams.r_fid = fopen(rxFilename,'rb');

%reading in doubles from bin file
rx_file = fread(rxFileParams.r_fid,2*readIn*rxFileParams.fs ,'double');

%changing into complex numbers
rx = rx_file(1:2:end) + 1j*rx_file(2:2:end);

%changing column into row
rx = rx.';

%Plotting time domain of tx signal
subplot(2,2,3)
ax = (1:1:length(rx))*1/rxFileParams.fs;
plot(ax, real(rx))
xlabel("time - s")
ylabel("amplitude - db")
title("TIME DOMAIN OF RX SIGNAL")


%Plotting Tx Frequency Domain
subplot(2,2,4)
ax = (1:1:length(rx))*rxFileParams.fs/length(rx) - rxFileParams.fs/2;
plot(ax/1e6, 20*log10(abs(fftshift(fft(rx)))))
xlabel("frequency - Mhz")
ylabel("amplitude - db")
title("FREQUENCY DOMAIN OF RX SIGNAL")

%resampling to system frequency
rx = resample(rx, fs, rxFileParams.fs);

sgtitle('PLOTS SHOWING READ IN DATA') 

%% Conditioning for RD

%new figure/subplots for the ard generation
figure

%prepending zeroes to round to closest prf after sampling delay
rx = [zeros(1, settle*fs) rx];

%removing first pulse in order to remove added zeros
rx = rx(1,(settle+prt)*fs :end);

%% RD Prep

subplot(2,2,1)
plot((1:1:length(rx))*1/fs, real(rx));
xlabel("time - s")
ylabel("amplitude - lin")
title("TIME DOMAIN OF RX SIGNAL (shifted to prf)")

%preallocating memory 
RD = zeros(maxPulses, floor(fs/prf));

nPulses = 0;

while nPulses < maxPulses

    %taking slow time cut
    RD(nPulses+1,:) = rx(1,1:fs/prf);
    %removing cut from data
    rx = rx(1, (fs/prf)+1:end);

    nPulses = nPulses +1 ;
end

%cutting excess if leftover rows of zeros
RD = RD(1:nPulses,:);

subplot(2,2,2)
plot((1:1:length(RD(1,:))), real(RD(1:4,:)));
xlabel("time - s")
ylabel("amplitude - lin")
title("TIME DOMAIN OF SINGLE RX SLOW TIME SLICE")

%% Creating Matched Filter

mf = tx;
fill = floor(fs/prf) - length(tx);
mf = [mf zeros(1,fill)];
mf = conj(flip(mf));


% 
% t = rx(1:1000000);
% 
% t = conv(t,mf);
% 
% figure
% plot(1:1:length(t),abs(t))
% 
% a = conv(tx,mf);
% figure
% plot(1:1:length(a),abs(a))


subplot(2,2,3)
plot(1:1:length(mf), real(mf))
xlabel("time - s")
ylabel("amplitude - lin")
title("TIME DOMAIN MATCHED FILTER")

MF = fft(mf);
MF = repmat(MF, nPulses,1);

%% ARD Frequency
% 
%fft along rows

% RD = conv2(RD.',mf.', "same").';

RD = fft(RD,[],2);
% 
% %cutting redundant info
% MF = MF(:, length(MF)/2:end);
% RD = RD(:, length(RD)/2:end);
% 
%matching in frequency domain
RD = RD.*MF;
% 
%plotting matched response
subplot(2,2,4)
plot(1:1:length(RD(1,:)),abs(fftshift(ifft(RD(1,:)))));
title("mf response")

% RD = conv2(RD.',mf.', "same").';
% RD = fftshift(fft2(RD));

% RD = fftshift(fft2(RD),1);
% RD = flip(RD,2);

RD = ifft(RD,[],2);
RD = fftshift(fft(RD,[],1));
% RD = flip(RD,2);


%RD = fftshift(fft(RD),1);
% RD = flip(RD, 2);



%

vres = c*prf/(2*fc*size(RD,1));

velocityAxis = (-size(RD,1)/2+1:size(RD,1)/2)-1; %hz

dopplerAxis = velocityAxis*2*(c/fc); %m/s

delayAxis = (1:size(RD,2)/2)*c/(fs*1000); %km
% 
figure
imagesc(delayAxis,dopplerAxis, 20*log10(abs(RD)))
%imagesc(delayAxis,dopplerAxis, (abs(RD(:,length(RD)/2:end))))
xlabel("range - km")
ylabel("doppler - hz")
% % s = surf((abs(RD)));
% % set(s, "linestyle", "none")


%% ARD Time