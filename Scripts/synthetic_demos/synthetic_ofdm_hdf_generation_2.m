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


%DAB_MODE DESCRIPTION
%     dab_mode.K         = 20;
%     dab_mode.L         = 3;
%     dab_mode.Tnull     = 0;
%     dab_mode.Tu        = 2048;
%     dab_mode.Tg        = 504;
%     dab_mode.Ts        = dab_mode.Tu + dab_mode.Tg;
%     dab_mode.Tp        = dab_mode.Tnull + (dab_mode.L)*dab_mode.Ts;
%     dab_mode.mask      = [ (dab_mode.Tu/2-dab_mode.K/2 +1):(dab_mode.Tu/2), ...
%                                     (dab_mode.Tu/2+2):(dab_mode.Tu/2+dab_mode.K/2 +1) ];
%     dab_mode.p_intra   = 1;
%     dab_mode.T_intra   = 0;
%     dab_mode.Tf        = (dab_mode.Tp + dab_mode.T_intra)*dab_mode.p_intra;
%================================================
%================================================

display = 0;

%% WAVEFORM PARAMETERS
n = 2;

%CHOOSE NEW CONSTANT
dab_mode = load_dab_rad_constants(8);

onez = (dab_mode.L*dab_mode.p_intra*dab_mode.K-dab_mode.K)*2/2;
zeroz = (dab_mode.L*dab_mode.p_intra*dab_mode.K-dab_mode.K)*2/2;
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
L_0 = L ;
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
%intra frame time: spacing between pulses within a frame
T_intra = dab_mode.T_intra;


%% ENCODING BITS
% 
[F, A_pulses] = bits_to_phase_cube(bits,n,dab_mode);

%removing null o make basic pulse wave
A_pulses = A_pulses(:,2:end,:);

%Frequency weights ()
%time per symbol
W_cube = ones(L_0,K_0,F);
W_cube = rescale_cube_to_unity_weights(W_cube,F);

%for randos :)
W_cube = randn([L,K+1,F]) + 1i*randn([L,K+1,F]);
A_pulses = randn([F , L,K+1]);

symbol_time = 1:1:Ts;

%% GENERATING WAVEFORM

%generating all envelopes of framestx = tx(1:4096);
S = gen_all_pulses(symbol_time, F, L_0, Tu, Ts, Tg, K,W_cube,A_pulses);

%interframe time
tif_time = linspace(T,T_intra,T_intra);

%adding in interframe time periods
S = insert_inter_frame_time(S, F, tif_time);

%% PLOTTING
    
%converting rows to columns
S = S';
%stacking all columns the transposing
S = S(:)';

S = [S zeros(1,delay_samps)];


%% WRITTING TO FILES

create_hdf5('emission_f0',S);

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
% b = zeros(2,length(S))fc32 - complex<float>;
% b(1,:)=real(S);
% b(2,:)=imag(S);
a(1,:)=real(S);
a(2,:)=imag(S);


fid = fopen('tmp.bin', 'w');
a = single(a);
fwrite(fid, a, 'float32');
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



if ~display
    close all
end




















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












