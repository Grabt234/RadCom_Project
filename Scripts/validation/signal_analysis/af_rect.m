clear all
close all

%================================================
% Demonstrates the AF of a 1ms pulse
%================================================


%% Data Config

fs = 2.048e6;

iq = [ones(1,2048) zeros(1,1000)];

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
range = ((1:1:length(acf)) - length(acf)/2)*(3e8/(2*fs*1000)); 
doppler = ((1:1:size(acf,1)) - size(acf,1)/2)*(fs/(1000*length(tx))); 

%range bound
rBound = 2000;
rStart = length(acf)/2 - rBound;
rEnd = length(acf)/2 + rBound;

%doppler bound
dBound = 100;
dStart = size(acf,1)/2 - dBound;
dEnd = size(acf,1)/2 + dBound;

s = imagesc(range(1,rStart:rEnd), doppler(dStart:dEnd), ...
    (20*log10(abs(acf(dStart:dEnd,rStart:rEnd))./max(abs(acf),[],"all"))));

%pretty stuffs
% set(s,"linestyle", "none")
% lighting flat
xlabel("Range - [Km]","FontSize",16)
ylabel("Doppler - [KHz]","FontSize",16)
zlabel("Magnitude - [dB]","FontSize",16)
zlim([-50 0])
caxis([[-50 0]])
colorbar
