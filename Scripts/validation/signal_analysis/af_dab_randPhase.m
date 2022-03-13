clear all
close all

%================================================
% Demonstrates the AF of an ofdm signal WITH
% DQPSK - frequency independant
%================================================

%% Defining DAB mode

dab_mode.K         = 1300;
dab_mode.L         = 5;
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
dab_mode.f0        = 2.048e6;
dab_mode.ftx        =2.5e6; 

%% Generating Wave

n=2;
frames = 1;
onez = frames*((dab_mode.L-2)*dab_mode.K)*2/2;
zeroz = frames*((dab_mode.L-2)*dab_mode.K)*2/2;
bits = [ones(1,onez), zeros(1,zeroz)];
bits = bits(randperm(numel(bits)));
bits = num2str(bits,'%i');

f0 =  dab_mode.f0;
txf0 = dab_mode.ftx;
T = 1/f0;

delay_samps = dab_mode.Td;

%% EXTRACTING DAB_CONSTANTS

%symbols
L = dab_mode.L;
L_0 = L;
%carriers no center
K = dab_mode.K ;    
%carriers incl. center
K_0 = dab_mode.K + 1;
%integration period
Tu = dab_mode.Tu;
%symbol period
Ts = dab_mode.Ts;
%gaurd inteval
Tg = dab_mode.Tg;

% ENCODING BITS

[F, A_cube] = bits_to_phase_cube(bits,n,dab_mode);

%Frequency weights 
W_cube = ones(F,L_0,K_0);
W_cube = rescale_cube_to_unity_weights(W_cube,F);

A_cube = (rand(1,L_0,K_0)-0.5) + (rand(1,L_0,K_0)-0.5)*1i ;  
A_cube = A_cube./abs(A_cube);

%Generating iq data
iq = gen_all_frames(Ts , Tu ,Tg, K, W_cube, A_cube, L, F);

%extracting rand phase symbol

iq = iq(1*2048:3*2048);
%% AF generation

iq = [iq zeros(1,5*length(iq))];
mf = flip(conj(iq));

figure
subplot(1,2,1)
plot(1:1:length(iq),real(iq))
title("PORTION OF TX DATA")
subplot(1,2,2)
plot(1:1:length(iq),abs(fftshift(fft(iq))))

TX = fft(iq)/length(iq);
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
doppler = ((1:1:size(acf,1)) - size(acf,1)/2)*(dab_mode.f0/(1000*length(iq)));%(dab_mode.L*dab_mode.Tu*1/dab_mode.f0); %vMt_b %levananon 

rBound = 50;
rStart = length(acf)/2 - rBound;
rEnd = length(acf)/2 + rBound;

dBound = 50;
dStart = size(acf,1)/2 - dBound;
dEnd = size(acf,1)/2 + dBound;

s = surf(range(1,rStart:rEnd), doppler(dStart:dEnd), ...
    (20*log10(abs(acf(dStart:dEnd,rStart:rEnd))./max(abs(acf),[],"all"))));

set(s,"linestyle", "none")
lighting flat
xlabel("Range - [Km]","FontSize",30)
ylabel("Doppler - [KHz]","FontSize",30)

figure
imagesc(range(1,rStart:rEnd), doppler(dStart:dEnd), ...
    20*log10(abs(acf(dStart:dEnd,rStart:rEnd))./max(abs(acf),[],"all")))
xlabel("Range - [Km]","FontSize",30)
ylabel("Doppler - [KHz]","FontSize",30)
colorbar