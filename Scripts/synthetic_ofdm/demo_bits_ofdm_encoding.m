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
% T   - Elementary period
%
% N   - Number of sub carriers in signal: excluding center
% N_0 - Number of sub carriers in signal inclding center
% L   - Symbols per frame
% Ts  - Elementary periods per symbol
% Tu  - Elementary periods per integration period
% Tg  - Elementary periods in the gaurd interval
%================================================
%================================================


%================================================
% Definitions
%================================================
n = 2;
bits = '011011100001111001100';

L = 4;
N = 2; %must be even number of subcarriers
N_0 = N+1; % including 0th subcarrier

f0 = 0.05*10^6;
T = 1/f0;

a = 2048;
b = 1800;
d = 5000;

Ts  = a*T;
Tu  = b*T;
Tg  = (a-b)*T;

%F = 3;     redfined due as per bit stream requirements
Tif = d*T; %assinged inter-frame time period to be same as frame period
%================================================
%================================================



%================================================
% Configurations
%================================================
%Phase weights ( (L x N) x F) )
%this portion of code will determine F frames 
%(dependant on bitstream length)
[F, A_cube] = bits_to_phase_cube(bits,n,L,N);

%Frequency weights ()
W_cube = ones(L,N_0,F);
W_cube = rescale_cube_to_unity_weights(W_cube,F);

%================================================
%================================================



%================================================
% Generation
%================================================
%time per symbol
symbol_time = linspace(T,Ts,a);

%generating all envelopes of frames
S = gen_all_pulses(symbol_time, F, L, Tu, Ts, Tg, N,W_cube,A_cube);

%interframe time
tif_time = linspace(T,Tif,d);

%adding in interframe time periods
S = insert_inter_frame_time(S, F, tif_time);

%================================================
%================================================


%converting rows to columns
S = S';
%stacking all columns the transposing
S = S(:)';

tot_time = linspace(T,F*L*(a+d)*T, F*(L*(a)+d) );
length(S)
length(tot_time)
plot(tot_time, S)























