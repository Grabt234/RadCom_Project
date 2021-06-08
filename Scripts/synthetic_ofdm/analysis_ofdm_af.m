%=================================
% Key 
%=================================
% f0  - Center frequency 
% T   - Elementary period
%
% N   - Number of sub carriers in signal: excluding center
% N_0 - Number of sub carriers in signal inclding center
% L   - Symbols per frame
% Ts  - Elementary periods per symbol
% Tu  - Elementary periods per integration period
% Tg  - Elementary periods in the gaurd interval
%
% a   - Number elementary periods in symbol period
% b   - Number elementary periods in integration period
% d   - Number elementary periods in interframe period
%
% F   - Number of frames (dependant of bits)
%================================================
%================================================


%================================================
% Definitions
%================================================
f0 = 100*10^6;
T = 1/f0;

a = 50;
b = 10;
d = 0;

N = 4; %must be even
N_0 = N+1; % including 0th subcarrier
L = 7;
Ts  = a*T;
Tu  = b*T;
Tg  = (a-b)*T;

F = 2;
Tif = d*T; %assinged inter-frame time period to be same as frame period 

t_sig = F*(L*(a)+d); %in emelentary periods
osf = 4; %over_sample_factor
%================================================
%================================================



%================================================
% Configurations
%================================================
%frequency weights (N x L x F)

W_cube = ones(L,N_0,F);
%W_cube = gen_rand_freq_weights_cube(L,N_0,F);
W_cube = rescale_cube_to_unity_weights(W_cube,F);
W_cube(:,((N)/2)+1,:) = zeros(L,1,F);

%taking transpose to turn into vector
A_cube = ones(L,N_0,F);
%A_cube = gen_rand_frame_phase_weights(L,N_0,F);
%================================================
%================================================



%================================================
% Generation
%================================================
%time per symbol
symbol_time = linspace(T,Ts,a*osf);

%generating all envelopes of frames
S = gen_all_frames(symbol_time, F, L, Tu, Ts, Tg, N,W_cube,A_cube);

%interframe time
tif_time = linspace(T,Tif,d*osf);

%adding in interframe time periods
S = insert_inter_frame_time(S, F, tif_time);

%converting rows to columns
S = S';
%stacking all columns the transposing
S = S(:)';


%================================================
%================================================

tot_time = linspace(T,t_sig*T, t_sig*osf );
S_0 = gen_center_frequency(T,tot_time);

S = S_0.*S;



%================================================
% Analysis
%================================================
% pad = 50000;
% S = [S zeros(1,pad)];
% T_sample = T/osf;        % Sampling period  
% Fs = 1/T_sample;         % Sampling frequency                    
% L = length(S);         % Length of signal
% 
% 
% figure
% 
% X = fft(S);
% 
% P2 = abs(X/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% 
% f = Fs*(0:(L/2))/L;
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')

%================================================
% Additional Definitions
%================================================;
% added noise to prevent flooring when conveting to log
S = awgn(S,20);

pulse_width = (L-1)*Ts;
rest_time = Tif + Ts;
prt = (pulse_width + rest_time);
prf = 1/prt;

%================================================
% Ambiguity
%================================================
L = 1:length(S);
plot(L,S)
ambiguity_function_V4(S, T, osf, tot_time,prf)


clear








