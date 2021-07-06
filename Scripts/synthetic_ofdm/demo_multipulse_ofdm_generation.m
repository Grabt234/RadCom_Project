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
% d   - Number elementary periods in intraframe period
% e   - Number elementary periods in interframe period
%
% F_intra   - Number of intraframe pulses (dependant of bits)
%================================================
%================================================


%================================================
% Definitions
%================================================
f0 = 2.048*10^6;
T = 1/f0;

a = 25;
b = 18;
d = 150;  
e = 1800; %inter frame times

N = 10;
N_0 = N+1; % including 0th subcarrier
L = 5;
Ts  = a*T;
Tu  = b*T;
Tg  = (a-b)*T;

F_intra = 6;
F_inter = 3; 
Tif = d*T; %assinged intra-frame time period to be same as frame period 
Tiif = e*T; %assinged inter-frame time period to be same as frame period

tt = (L*(a)+d);
T_frame_time = F_intra*(L*(a)+d); %in emelentary periods
osf = 10; %over_sample_factor
%================================================
%================================================



%================================================
% Configurations
%================================================
%frequency weights (N x L x F)
W_cubes = ones(L,N_0,F_intra, F_inter);
W_cubes = rescale_cubes_to_unity_weights(W_cubes,F_inter,F_intra);

%taking transpose to turn into vector
A_cubes = gen_rand_frame_phase_weights_cubes(L,N_0,F_intra,F_inter);
size(A_cubes)
%================================================
%================================================

% 
% 
% %================================================
% % Generation
% %================================================
% S_fs = generate_frames(N, L, T, Ts, Tu, Tg, Tif, a, d, osf, W_cubes, A_cubes ...
%                                               ,F_intra,F_inter,T_frame_time);
% tiif_time = linspace(T,Tiif,e*osf);
% 
% length(tiif_time)
% S_fs = insert_inter_frame_time(S_fs,F_inter,tiif_time);
% 
% S_fs = S_fs';
% frames = S_fs(:)';
% %================================================
% %================================================
% temp = linspace(1,length(frames),length(frames));
% 
% length(frames)
% length(temp)
% 
% plot(temp, frames)




