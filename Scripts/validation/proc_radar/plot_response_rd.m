
%================================================
% Demonstrates the RD msp of an ofdm signal (prs) 
% with data generated using FERS
%================================================


%%
close all
clear all

%% Dab Mode

dab_mode.K         = 1500;
dab_mode.L         = 1;
dab_mode.Tnull     = 0;
dab_mode.Tu        = 1*2048;
dab_mode.Tg        = 0;
dab_mode.Td        = 2*2048;
dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
dab_mode.p_intra   = 1;
dab_mode.T_intra   = 0;
dab_mode.Tf        = (dab_mode.Tp + dab_mode.T_intra)*dab_mode.p_intra;
dab_mode.f0        = 2*2.048e6;
dab_mode.ftx        =2*2.5e6;

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
skip =0;% 24*dab_mode.ftx*2*4; %to skip forward ina binary file  
coCount = 5; % # pulses for coherent integration 

%hardware sampling rates
txFileParams.fs = dab_mode.ftx;

cableSpeed = 1; % as a factor fo the speed of light
c= 299792458*cableSpeed;

%% RX TX Signals

%transmitted file parameters
txFilename = "synthetic_demos/tmp.bin";

%file reading configurations
txFileParams.fileType = 'Bin';
txFileParams.dataType = 'float32=>double';  

tx = loadfersHDF5_iq("emission_f0.h5");


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

%% RD Prep

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

RD2 = zeros(nPulses, length(mf)+ length(RD(1,:)) - 1);

for i = 1:size(RD,1)
    
    RD2(i,:) = conv(mf,RD(i,:));

end

%% Coherent Integration
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

%doppler fft of RD
RD = fft(RD,[],1);
RD = fftshift(RD,1);

%% Plotting

%axes
vmax = (prf*c/fc)/4; %c/(4*fc*prt); %koks 8.10

velocityAxis = (-size(RD,1)/2+1:size(RD,1)/2)-1; %hz

velocityAxis = velocityAxis*vmax/(size(RD,1)*coCount/2); %m/s

delayAxis = (1:1:size(RD,2))*c/(f0*2*1000); %km


figure

%allows for variable range cutoffs
if range == 0
    imagesc(delayAxis,velocityAxis, 20*log10(abs(RD)))
else
    imagesc(delayAxis(1:range),velocityAxis, 20*log10(abs(RD(:,1:range))))
end

xlabel("Range - [Km]","FontSize",16)
ylabel("Velocity - [^{m}/s]","FontSize",16)
colorbar

figure
if range == 0
   h = surf(delayAxis,velocityAxis,20*log10(abs(RD)));
else
    h = surf(delayAxis(1:range),velocityAxis,20*log10(abs(RD(:,1:range))));
end

h.LineStyle = "none";
xlabel("Range - [Km]","FontSize",16)
ylabel("Velocity - [^{m}/s]","FontSize",16)
