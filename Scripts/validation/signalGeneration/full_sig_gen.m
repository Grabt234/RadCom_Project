

%% WAVEFORM PARAMETERS
n = 2;

%CHOOSE NEW CONSTANT
dab_mode = load_dab_rad_constants(8);

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
S = gen_all_frames(Ts , Tu ,Tg, K, W_cube, A_cube, L, F);

%% PLOTTING
    
%converting rows to columns
S = S';
%stacking all columns the transposing
S = S(:)';

S = [S zeros(1,delay_samps)];

S_single = S;

%repeating to multiple pulses
S = repmat(S,[1,dab_mode.P]);

%% Plotting

figure
plot(1:1:length(S), S)
xlim tight
ylabel("Amplitude - [arb]", "FontSize", 16)
xlabel("Samples - [n]", "FontSize", 16)





