clear all
close all

%================================================
% Demonstrates the AF of an ofdm signal WITH
% DQPSK AND GUARD - frequency independant
%================================================

%% Defining DAB mode

dab_mode.K         = 1300;
dab_mode.L         = 2;
dab_mode.Tnull     = 0;
dab_mode.Tu        = 2048;
dab_mode.Tg        = 504;
dab_mode.Td        = 0;
dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
dab_mode.p_intra   = 1;
dab_mode.T_intra   = 0;
dab_mode.Tf        = (dab_mode.Tp + dab_mode.T_intra)*dab_mode.p_intra;
dab_mode.f0        = 2.048e6;
dab_mode.ftx        =2.5e6; 


%% Loading in Data

iq = loadfersHDF5_iq("signal_analysis/emission_guard.h5");

startIndex = 1;%*factor*2048;
stopIndex = 0;%10*factor*2048;

if stopIndex == 0
    tx = iq(startIndex:end);
else
    tx = iq(startIndex:stopIndex);
end

tx = [tx zeros(1,5*length(tx))];
mf = flip(conj(tx));

figure
subplot(1,2,1)
plot(1:1:length(tx),real(tx))
title("PORTION OF TX DATA")
subplot(1,2,2)
plot(1:1:length(tx),abs(fftshift(fft(tx))))

TX = fft(tx)/length(tx);
MF = fft(mf)/length(mf);

dopLim = 200;
dopShifts = -dopLim:1:dopLim;

acf = zeros(length(dopShifts),length(TX));

for i = 1:length(dopShifts)
    dopShifts(i)
    acf(i,:) = fftshift(ifft(circshift(TX,dopShifts(i),2).*MF));

end

%% Plotting

figure
range = ((1:1:length(acf)) - length(acf)/2)*3e8/(2*1000*dab_mode.f0); %tau/tb
doppler = ((1:1:size(acf,1)) - size(acf,1)/2)*(dab_mode.f0/(1000*length(tx)));%(dab_mode.L*dab_mode.Tu*1/dab_mode.f0); %vMt_b %levananon 

rBound = 2500;
rStart = length(acf)/2 - rBound;
rEnd = length(acf)/2 + rBound;

dBound = 100;
dStart = size(acf,1)/2 - dBound;
dEnd = size(acf,1)/2 + dBound;

s = surf(range(1,rStart:rEnd), doppler(dStart:dEnd), ...
    (20*log10(abs(acf(dStart:dEnd,rStart:rEnd))./max(abs(acf),[],"all"))));

set(s,"linestyle", "none")
lighting flat
xlabel("Range - [Km]","FontSize",16)
ylabel("Doppler - [KHz]","FontSize",16)

figure
imagesc(range(1,rStart:rEnd), doppler(dStart:dEnd), ...
    20*log10(abs(acf(dStart:dEnd,rStart:rEnd))./max(abs(acf),[],"all")))
xlabel("Range - [Km]","FontSize",16)
ylabel("Doppler - [KHz]","FontSize",16)
colorbar