clear all
close all


fs = 2*2.048e6;

dab_mode = load_dab_rad_constants(8);

iq = loadfersHDF5_iq("synthetic_demos/emission_f0.h5");

startIndex = 1%*factor*2048;
stopIndex = 0;%10*factor*2048;

if stopIndex == 0
    tx = iq(startIndex:end);
else
    tx = iq(startIndex:stopIndex);
end

%tx = [zeros(1,400) ones(1,100) zeros(1,400)]

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


% TX = [zeros(1,0.5*length(TX)) TX zeros(1,0.5*length(TX))]; 
% MF = [zeros(1,0.5*length(MF)) MF zeros(1,0.5*length(MF))]; 

dopLim = 200;
dopShifts = -dopLim:1:dopLim;

acf = zeros(length(dopShifts),length(TX));

for i = 1:length(dopShifts)
    dopShifts(i)
    acf(i,:) = fftshift(ifft(circshift(TX,dopShifts(i),2).*MF));

end

%% Plotting

figure
range = ((1:1:length(acf)) - length(acf)/2)*1/dab_mode.Tu; %tau/tb
doppler = ((1:1:size(acf,1)) - size(acf,1)/2)*(dab_mode.L*dab_mode.Tu*1/dab_mode.f0); %vMt_b %levananon 

rBound = 100;
rStart = length(acf)/2 - rBound;
rEnd = length(acf)/2 + rBound;

dBound = 100;
dStart = size(acf,1)/2 - dBound;
dEnd = size(acf,1)/2 + dBound;

s = surf(range(1,rStart:rEnd), doppler(dStart:dEnd), ...
    (20*log10(abs(acf(dStart:dEnd,rStart:rEnd))./max(abs(acf),[],"all"))));

set(s,"linestyle", "none")
lighting flat
xlabel("Range - ^{\tau}/_{t_{u}}","FontSize",16)
ylabel("Doppler - VLT_{u}","FontSize",16)

figure
imagesc(range(1,rStart:rEnd), doppler(dStart:dEnd), ...
    20*log10(abs(acf(dStart:dEnd,rStart:rEnd))./max(abs(acf),[],"all")))
xlabel("Range - ^{\tau}/_{t_{u}}","FontSize",16)
ylabel("Doppler - VLT_{u}","FontSize",16)