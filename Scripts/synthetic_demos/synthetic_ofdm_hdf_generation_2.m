    %=================================
% Key 
%=================================
% n    - Number of bits encoded in a single letter
% bits - The bit stream to be converted to phase codes 
%
% map  - The alphabet mapping
%
% L    - Number of symbols in a frame
% N    - Number of sub carriers in a symbol
% F    - number of frames in a signal (dependant of bitstream size)
%
% f0  - Center frequency 
% T      - Elementary period
%
% N   - Number of sub carriers in signal: excluding center
% N_0 - Number of sub carriers in signal inclding center
% L   - Symbols per frame
% Ts  - Elementary periods per symbol
% Tu  - Elementary periods per integration period
% Tg  - Elementary periods in the gaurd interval
%================================================
%================================================

display = 0;

%% Deleteing previuosly generated file

delete("emission_single.h5");
delete("emission.h5");

%% WAVEFORM PARAMETERS
n = 2;

%CHOOSE NEW CONSTANT
dab_mode = load_dab_rad_constants(3);

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

symbol_time = 1:1:Ts;

%% removing nulls

% uincomment to remove null to make basic pulse wave
% A_pulses = A_pulses(:,2:end,:);
% W_cube = W_cube(:,2:end,:);
% L_0 = L_0 - 1; %remvoed null tf symbols go down
%% GENERATING WAVEFORM

%generating all envelopes of framestx = tx(1:4096);
S = gen_all_frames(Ts , Tu ,Tg, K, W_cube, A_cube, L, F);
% 
% p = S(2049:2*2048);
% plot(((1:1:length(p))-length(p)/2 -1)*f0/(length(p)*1000), abs(fftshift(fft(p))));
% %xlim([-1024 1024])
% ylabel("Amplitude [arb]",'FontSize',15)
% xlabel("Frequency [KH]",'FontSize',15)
% title("FFT OF OFDM SYMBOL USING THE SINGAL GENERATION CHAIN AND DAB MODE 2")
%interframe time


%% PLOTTING
    
%converting rows to columns
S = S';
%stacking all columns the transposing
S = S(:)';

S = [S zeros(1,delay_samps)];

S_single = S;

%repeating to multiple pulses
S = repmat(S,[1,dab_mode.rep]);

% S = [exp(j*2*pi*(zeros(1,50))) 0*exp(j*2*pi*(zeros(1,950)))] ;
%% WRITTING TO FILES

create_hdf5('emission_single',S_single);
create_hdf5('emission',S);

figure
plot(1:1:length(S), S)
xlabel("samples - n")
title("ORIGNAL SAMP RATE")

S = resample(S,txf0,f0);

figure
plot(1:1:length(S), S)
xlabel("samples - n")

figure
plot((1:1:length(S))*1/txf0, S)
xlabel("time - s")

a = zeros(2,length(S));
% b = zeros(2,length(S));
% b(1,:)=real(S);
% b(2,:)=imag(S);
a(1,:)=real(S);
a(2,:)=imag(S);

fid = fopen('tmp.bin', 'w');
fwrite(fid, a, 'double');
fclose(fid);

% fid = fopen('tmp2.bin', 'w');
% fwrite(fid, b, 'double');
% fclose(fid);

% fid = fopen('tmp.bin', 'r');
% b = fread(fid, 4, 'double');
% b=b(1:2:end)+j*b(2:2:end)
% fclose(fid);


% a = [real(S) imag(S)];

% fileID = fopen('tmp.bin','w');
% fwrite(fileID,a,'double')
% fclose(fileID);

fid =fopen('bits.txt', 'w' );
fwrite(fid, bits);
fclose(fid);



% if ~display
%     close all
% end







%% for a pretty prectorgram insert at line 100-101


% a = reshape(S,2048,[]);
% 
% A = fftshift(fft(a,[],1));
% b = 30;
% d = 5;
% A = [A zeros(2048,b) A zeros(2048,b) A ];
% A = A.';
% 
% h = surf(abs(A));
% colour = [0, 0.4470, 0.7410];
% colormap 'white'; 
% h.FaceLighting = 'flat';
% h.EdgeAlpha = 1;
% h.EdgeColor = colour;
% h.EdgeLighting = 'gouraud';
% xlabel("Carrier [K]");
% ylabel("Symbol Index [L]",'FontSize',15);
% zlabel("Magnitude [arb]",'FontSize',15);
% title("FREQUNECY DOMAIN SPECTROGRAM OF OFDM SYMBOL GENERATED USING AN ARBITRARY DAB MODE",'FontSize',17)
% 
% 






%% debug code
% scale = 0;
% % symbol n
% a = S( (scale)*dab_mode.Ts + dab_mode.Tg + 1:(scale)*dab_mode.Ts   + dab_mode.Tg + dab_mode.Tu );
% % symbol n + 1
% b = S((scale+1)*dab_mode.Ts+ dab_mode.Tg + 1:(scale+1)*dab_mode.Ts + dab_mode.Tg + dab_mode.Tu );
% 
% c = S((scale+2)*dab_mode.Ts+ dab_mode.Tg + 1:(scale+2)*dab_mode.Ts + dab_mode.Tg + dab_mode.Tu );
% 
% d = S((scale+3)*dab_mode.Ts+ dab_mode.Tg + 1:(scale+3)*dab_mode.Ts + dab_mode.Tg + dab_mode.Tu );
% 
% 
% 
% A = fftshift(fft(a))./length(a);
% B = fftshift(fft(b))./length(b);
% C = fftshift(fft(c))./length(c);
% D = fftshift(fft(d))./length(d);
% 
% BB = B./A; %finding
% CC = C./B;
% DD = D./C;
% % 
% % figure
% % plot(1:1:length(A),(abs(A)))
% 
% phase_codes = [round(wrapTo360(rad2deg(angle(BB(dab_mode.mask))))) round(wrapTo360(rad2deg(angle(CC(dab_mode.mask))))) round(wrapTo360(rad2deg(angle(DD(dab_mode.mask))))) ];
% 
% rx_bits = '';
% 
% mapper = define_inverse_alphabet_map(2);
% 
% for z = 1:numel(phase_codes)
%     
%    rx_bits = [rx_bits  mapper(phase_codes(z))];
% 
% end
% 
% %reference bits
% fileID = fopen('bits.txt','r');
% ref_bits = fscanf(fileID,'%s');
% fclose(fileID);

% ref=char(num2cell(ref_bits));
% ref=reshape(str2num(ref),1,[]);
% 
% output=char(num2cell(rx_bits));
% output=reshape(str2num(output),1,[]);
% 
% results = rx_bits - ref_bits;
% results = (string(results));
% results = horzcat(results{:})












