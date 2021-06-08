pl = 300;
S = [ ones(1, pl) zeros(1,pl) ];
fs = 1e9;
fc = 200e6;
T = 1/fs;
prf = 1/(T*length(S));
osf = 1;
pulse_length = pl*T
ambiguity_function_V4_1(S,T,fc,pl,5,100);