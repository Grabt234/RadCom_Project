%%Notes

%TX file should be generated at the ideal system sampling rate, not what is
%   use in the physiocal hardware
%%
close all
clear all

dab_mode = load_dab_rad_constants(8);
a = 50;
%% RF Parameters
range = 100;
%system sampling rate
f0 =  dab_mode.f0;
fc = 2.45e9;
readIn = 3; %s
d = dab_mode.Td;
tau = dab_mode.Td + dab_mode.Tf;
prt = (tau)*1/f0;
prf = 1/prt;
maxPulses = 250;
skip =(0*dab_mode.ftx)*2*4;% 24*dab_mode.ftx*2*4;
%txFileParams.fs = 2.5e6;
%rxFileParams.fs = 2.5e6;   
%coherent integration?
coCount = 1;

%hardware sampling rates
txFileParams.fs = dab_mode.ftx;
rxFileParamslb.fs = dab_mode.ftx;
rxFileParams.fs = dab_mode.ftx;

%delay bef.ore data starts being taken by hardware
settle = 0;
% delay = settle + 10*prt*fs;
cableSpeed = 1; % as a factor fo the speed of light
c= 299792458*cableSpeed;

%% TX Params Config

%transmitted file parameters
txFilename = "synthetic_demos/tmp.bin";

%file reading configurations
txFileParams.fileType = 'Bin';
txFileParams.dataType = 'float32=>double';  

%% RX LOOPBACK Param Config

rxFilenamelb = "synthetic_demos/rx.00.dat";

%file reading configurations
rxFileParamslb.fileType = 'Bin';
rxFileParamslb.dataType = "double=>double";

%% RX Params Config

%transmitted file parameters
rxFilename = "synthetic_demos/rx.01.dat";

%file reading configurations
rxFileParams.fileType = 'Bin';
rxFileParams.dataType = "double=>double";

%% TX Read In/Resample

% txFileParams.r_fid = fopen(txFilename,'rb');
% 
% %reading in doubles from bin file
% tx_file = fread(txFileParams.r_fid, txFileParams.dataType);
% 
% %closing file
% fclose(txFileParams.r_fid);
% 
% %changing into complex numbers
% tx = tx_file(1:2:end) + 1j*tx_file(2:2:end);
% 
% %changing column into row
% tx = tx.';
% 
% figure
% %Plotting time domain of tx signal
% subplot(3,2,1)
% ax = (1:1:length(tx))*1/txFileParams.fs;
% plot(ax, real(tx))
% xlabel("time - s")
% ylabel("amplitude")
% title("TIME DOMAIN OF TX SIGNAL")
% 
% %Plotting Tx Frequency Domain
% subplot(3,2,2)
% ax = (1:1:length(tx))*txFileParams.fs/length(tx) - txFileParams.fs/2;
% plot(ax/1e6, 20*log10(abs(fftshift(fft(tx)))))
% xlabel("frequency - Mhz")
% ylabel("amplitude")
% title("FREQUENCY DOMAIN OF TX SIGNAL")
% 
% %resampling to system frequency
% tx = resample(tx, f0, txFileParams.fs);

tx = loadfersHDF5_iq("emission_f0.h5");
%% RX LOOPBACK read in/Resample

% rxFileParamslb.r_fid = fopen(rxFilenamelb,'rb');
% 
% fseek(rxFileParamslb.r_fid, skip, "bof");
% 
% %reading in doubles from bin file
% rx_filelb = fread(rxFileParamslb.r_fid,2*readIn*rxFileParamslb.fs ,'double');
% 
% %closing file
% fclose(rxFileParamslb.r_fid);
% 
% %changing into complex numbers
% rx_lb = rx_filelb(1:2:end) + 1j*rx_filelb(2:2:end);
% 
% %changing column into row
% rx_lb = rx_lb.';
% 
% %Plotting time domain of tx signal
% subplot(3,2,3)
% ax = (1:1:length(rx_lb))*1/rxFileParamslb.fs;
% plot(ax, real(rx_lb))
% xlabel("time - s")
% ylabel("amplitude - v")
% title("TIME DOMAIN OF RX SIGNAL - LOOPBACK")

% 
% %Plotting Tx Frequency Domain
% subplot(3,2,4)
% ax = ((1:1:length(rx_lb)) -length(rx_lb)/2)*rxFileParamslb.fs/length(rx_lb);
% plot(ax/1e6, 20*log10(abs(fftshift(fft(rx_lb)./length(rx_lb)))))
% xlabel("frequency - MHz")
% ylabel("amplitude - dBm")
% title("FREQUENCY DOMAIN OF RX SIGNAL - FEEDTHROUGH")
% 
% %resampling to system frequency
% rx_lb = resample(rx_lb, f0, rxFileParamslb.fs);

%% RX read in/Resample

% rxFileParams.r_fid = fopen(rxFilename,'rb');
% 
% 
% fseek(rxFileParams.r_fid, skip, "bof")
% 
% %reading in doubles from bin file
% rx_file = fread(rxFileParams.r_fid,2*readIn*rxFileParams.fs ,'double');
% 
% %closing file
% fclose(rxFileParams.r_fid);
% 
% %changing into complex numbers
% rx = rx_file(1:2:end) + 1j*rx_file(2:2:end);
% 
% %changing column into row
% rx = rx.';
% 
% 
% %Plotting time domain of tx signal
% subplot(3,2,5)
% ax = (1:1:length(rx))*1/rxFileParams.fs;
% plot(ax, real(rx))
% xlabel("time - s")
% ylabel("amplitude - v")
% title("TIME DOMAIN OF RX SIGNAL")
% 
% 
% %Plotting Tx Frequency Domain
% subplot(3,2,6)
% ax = (1:1:length(rx))*rxFileParams.fs/length(rx) - rxFileParams.fs/2;
% plot(ax/1e6, 20*log10(abs(fftshift(fft(rx)./length(rx)))))
% xlabel("frequency - MHz")
% ylabel("amplitude - dBm")
% title("FREQUENCY DOMAIN OF RX SIGNAL")
% 
% %resampling to system frequency
% rx = resample(rx, f0, rxFileParams.fs);
% 
% sgtitle('PLOTS SHOWING READ IN DATA FROM GENERATED (1) AND RECORDED FILES (2,3)') 

%% Cancellation
    
% proc.cancellationMaxRange_m = 1500;
% proc.cancellationMaxDoppler_Hz = 5;
% proc.TxToRefRxDistance_m = 5;
% proc.nSegments = 16;
% proc.nIterations = 40;
% proc.Fs = f0;
% proc.alpha = 0;
% proc.initialAlpha = 0;

% rx = CGLS_Cancellation_RefSurv(rx_lb.' , rx.', proc).';

%% Creating Matched Filter


mf = conj(flip(tx(1:1*2048)));

figure
subplot(1,2,1)
plot(1:1:length(mf), real(mf))
xlabel("time - s")
ylabel("amplitude - lin")
title("TIME DOMAIN MATCHED FILTER")



subplot(1,2,2)
plot(1:1:length(mf), fftshift(abs(fft(mf))))
xlabel("time - s")
ylabel("amplitude - lin")
title("FREQUENCY DOMAIN MATCHED FILTER")

%% COMMUNICATIONS TIME ADJUSTMET

% 
% rx_lb = rx_lb(1,10*prt*f0:end);
% 
% t = rx_lb(1,1:f0/prf);
% 
% tt = conv(mf,t);
% tt = tt(length(mf):end);
% [~,I] = max(abs(tt));
% 
% tmp = rx(40*prt*f0+1:41*prt*f0);
% tmp = conv(mf,tmp);
% tmp = tmp(length(mf):end);
% 
% figure
% subplot(1,2,1)
% hold on
% plot((1:1:length(tt)), abs(tt)./max(abs(tt)));
% plot((1:1:length(tmp)), abs(tmp)./max(abs(tmp)));
% legend('Loopback','Transmitted path')
% hold off
% 
% % xlabel("time - s")
% % ylabel("amplitude - lin")
% title("FREQUENCY DOMAIN OF RX SIGNAL - LOOPBACK")

%% RD Prep

% %%removing offset and transient
% rx = rx(1,I:end);

rx = loadfersHDF5_cmplx("synthetic_demos/cw_response.h5");
%preallocating memory 
RD = zeros(maxPulses, prt*dab_mode.f0);

nPulses = 0;

while nPulses < maxPulses

    %taking slow time cut
    RD(nPulses+1,:) =  RD(nPulses+1,:)  + rx(1,1:f0/prf);
    rx = rx(1,2:end);
    %removing cut from data 
    rx = rx(1, (f0/prf):end); 
    
    nPulses = nPulses+1;

end

%cutting excess if leftover rows of zeros
RD = RD(1:nPulses,:);

subplot(1,2,2)
plot((1:1:length(RD(1,:))), real(RD(1:4,:)));
xlabel("time - s")
ylabel("amplitude - lin")
title("TIME DOMAIN OF SINGLE RX SLOW TIME SLICE")

%% ARD Frequency


% % %fft along rows to conver time domain signal to frequency domain
% RD = fft(RD,[],2)./length(RD);
% 
% %replicating mf to multiply with RD
% MF = repmat(MF, nPulses,1);
% % 
% % % RD(:,1:3) = 0;
% % % RD(:,length(RD)-1,:) = 0;
% % 
% %matching in frequency domain
% RD = RD.*MF;

% %plotting matched response
% subplot(1,2,2)
% plot(1:1:length(RD(1,:)),abs(fftshift(ifft(RD(4,:)))));
% title("mf response")
% % % 

RD2 = zeros(nPulses, length(mf)+ length(RD(1,:)) - 1);

for i = 1:size(RD,1)
    
    RD2(i,:) = conv(mf,RD(i,:));

end


counter = 0;        
RD3 = zeros(nPulses/coCount, size(RD2,2));

j = 1;
for i = 1:size(RD,1)
    
    RD3(j,:) = RD3(j,:) +  RD2(i,:);
    
    counter = counter + 1;
    
    
    if counter == coCount+1
        j = j+1;
        counter  = 1;
    end


end

RD2 = RD3;

RD2 = RD2(:,length(mf):end);

RD = RD2;

% RD = fftshift(ifft(RD,[],2));
RD = fft(RD,[],1);
RD = fftshift(RD,1);
% % 
%RD = RD(:,length(RD)/2 -1:end);


vmax = (prf*c/fc)/4; %c/(4*fc*prt); %koks 8.10

velocityAxis = (-size(RD,1)/2+1:size(RD,1)/2)-1; %hz

velocityAxis = velocityAxis*vmax/(size(RD,1)/2); %m/s

delayAxis = (1:1:size(RD,2))*c/(f0*2*1000); %km


figure

%allows for variable range cutoffs
if range == 0
    imagesc(delayAxis,velocityAxis, 20*log10(abs(RD)))
else
    imagesc(delayAxis(1:range),velocityAxis, 20*log10(abs(RD(:,1:range))))
end

xlabel("range - km")
ylabel("velocity - m/s")

figure
if range == 0
   h = surf(delayAxis,velocityAxis,20*log10(abs(RD)));
else
    h = surf(delayAxis(1:range),velocityAxis,20*log10(abs(RD(:,1:range))));
end

h.LineStyle = "none";
xlabel("range - km")
ylabel("velocity - m/s")
% % s = surf((abs(RD)));
% % set(s, "linestyle", "none")
