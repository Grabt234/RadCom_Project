%================================================
% Given a sequence with arbitrary number of 
% frames the prs symbols will be displayed in 
% continuous matched filter response
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
dab_mode.Tp        = (dab_mode.L-1)*dab_mode.Ts;
dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
dab_mode.rep       = 5;
dab_mode.Tf        = (dab_mode.Tnull + dab_mode.Tp + dab_mode.Td);
dab_mode.f0        = 2.048e6;
dab_mode.ftx       = 2.048e6;

%% Generating PRS

prs = build_prs_custom(dab_mode);

%% Loading in data stream

%================================================
% Given a sequence with arbitrary number of 
% frames the prs symbols will be displayed in 
% continuous matched filter response
%
% Note: null has been manually removed
%================================================

close all
clear all


%% WAVEFORM PARAMETERS
n = 2;


dab_mode.K         = 1000;
dab_mode.L         = 5;
dab_mode.Tnull     = 0;
dab_mode.Tu        = 2048;
dab_mode.Tg        = 504;
dab_mode.Td        = 2*(2048+504);
dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
                                (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];

dab_mode.P  = 5;
dab_mode.p_intra   = 1;
dab_mode.T_intra   = 0;
dab_mode.Tf        = (dab_mode.Tp + dab_mode.T_intra)*dab_mode.p_intra;
dab_mode.f0        =  2*2.048e6;
dab_mode.ftx       = 2*2.5e6;

%minus two: L1 Null, L2 PRS, these are only data carrying bits
frames = 1;
onez = frames*((dab_mode.L-2)*dab_mode.K)*2/2;
zeroz = frames*((dab_mode.L-2)*dab_mode.K)*2/2;
bits = [ones(1,onez), zeros(1,zeroz)];
bits = bits(randperm(numel(bits)));
bits = num2str(bits,'%i');

f0 =  dab_mode.f0;
txf0 = dab_mode.ftx;
T = 1/f0;

%
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

%% ENCODING BITS
% 
[F, A_cube] = bits_to_phase_cube(bits,n,dab_mode);

%Frequency weights 
W_cube = ones(F,L_0,K_0);
W_cube = rescale_cube_to_unity_weights(W_cube,F);

%% GENERATING WAVEFORM

%generating all envelopes of framestx = tx(1:4096);
s = gen_all_frames(Ts , Tu ,Tg, K, W_cube, A_cube, L, F);

%% PLOTTING
    
%converting rows to columns
s = s';
%stacking all columns the transposing
s = s(:)';

s = [s zeros(1,delay_samps)];

S_single = s;

%repeating to multiple pulses
s = repmat(s,[1,dab_mode.P]);

prs = build_prs_phase_codes(K);
prsl  = prs (1:K/2);
prsr = prs(K/2+1:end);
prs = [prsl 0 prsr];
prs = gen_symbol(Ts-Tg, Tu, 0, K, ones(1,K+1),prs);
mf = flip(conj(prs));

figure
subplot(4,1,1)
plot(1:1:length(mf), real(mf))
xlim tight
ylim padded
xlabel("Sample [n]", "FontSize", 16)
ylabel("Magnitude [Arb]", "FontSize", 16)

subplot(4,1,2)
plot(1:1:length(s), real(s))       
xlim tight
ylim padded
xlabel("Sample [n]", "FontSize", 16)
ylabel("Magnitude [Arb]", "FontSize", 16)

%% Adding noise

%s = awgn(s,0, "measured");

subplot(4,1,3)
plot(1:1:length(s), real(s))       
xlim tight
ylim padded
xlabel("Sample [n]", "FontSize", 16)
ylabel("Magnitude [Arb]", "FontSize", 16)

%% Demonstrating multi match

mf_resp = conv(s, mf);

subplot(4,1,4)
plot(1:1:length(mf_resp), (mf_resp))
xlim tight
ylim padded
xlabel("Sample [n]", "FontSize", 16)
ylabel("Magnitude [Arb]", "FontSize", 16)


%% Extracting first pulse/frame

prs_idx = prs_detect_rad(s,prs,dab_mode);

dab_pulse = frame_extract_rad(s, prs_idx, dab_mode);

figure
plot(1:1:length(dab_pulse), real(dab_pulse));
xlim tight
xlabel("Sample [n]", "FontSize", 16)
ylabel("Magnitude [Arb]", "FontSize", 16)



