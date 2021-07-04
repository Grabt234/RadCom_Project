%===========================================================
% Demonstrates (visually) how an ofdm pulse is constructed 
%===========================================================
%                           Key 
%===========================================================
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
% >F_intra -  number of intra frame pulses
%===========================================================
%%

%===========================================================
% Configurations
%===========================================================

f0 = 2.048*10^9;
T = 1/f0;

dab_mode = load_dab_rad_constants(4);

a = dab_mode.Tu+dab_mode.Tg;
b = dab_mode.Tu;
d = dab_mode.T_intra;

N = dab_mode.K;
N_0 = N+1; 
L = dab_mode.L;
Ts  = a*T;
Tu  = b*T;
Tg  = (a-b)*T;
Tif = d*T;

F_intra = dab_mode.F_intra;

t_sig = F_intra*(L*(a)+d);

osf = 1;

%% EXAMPLE: GENERATING FRAME PARAMETERS
symbol_time = linspace(T,Ts,a*osf)-T;

W_cube = ones(L,N_0,F_intra);

%non dqpsk, just phase codes
A_cube = gen_rand_frame_phase_weights_cube(L,N_0,F_intra);

%creating custom prs
prs = build_prs_phase_codes(dab_mode);
prs = repmat(prs,1,1,F_intra);

%inserting into first phase encoding position of every pulse
A_cube(2,:,:) = prs;

%rescaling to unity values
%A_cube = rescale_cube_to_unity_weights(A_cube,F_intra);

%compute dqpsk excluding sirst symbol
%A_cube(2,:,:) = convert_phase_cube_dpsk(A_cube(2,:,:));


%% CREATING ENVELOPE

s = gen_all_pulses(symbol_time,F_intra,L , Tu , Ts ,Tg, N,W_cube,A_cube);

s = insert_intra_frame_time(s,F_intra,d);

s = s';
s = s(:)';


tot_time = linspace(T,length(s), length(s) );
S_0 = gen_center_frequency(T,tot_time);

S = S_0.*s;

sig_length = length(S);

plot(tot_time,s);

figure

a = s(dab_mode.Ts:2*dab_mode.Ts-1);

plot(1:size(a,2),a);

a = [a zeros(1, dab_mode.Tu - dab_mode.Tg)];
b = fftshift( fft(a) );


plot(1:size(b,2),10*log(abs(b)));

create_hdf5('test',s);








































