
%% Plot the ambiguity function of any arbitrary waveform

%file name
hdf5_file_name_emission =  "cw_emission_5.h5"

%reading data from hdf5
cmplx_data_emission = loadfersHDF5_iq(hdf5_file_name_emission);

%% Read in the output of the PXGF to HDF5 conversion.

dab_mode = load_dab_rad_constants(3);
a= cmplx_data_emission(dab_mode.Ts+1:2*dab_mode.Ts);
Signal_ref = a;

Signal_surv = a;

Signal = a;

normalise = 0;

% Determine the frequency bins
fs_MHz = 2048; % Sampling frequency in MHz
fc = 2.45e3; % Centre frequency in MHz
T = fs_MHz/(max(size(Signal))-1); % Bin size
bins = ((fc-fs_MHz/2):T:(fc+fs_MHz/2))'; % Vector containing each bin in frequency steps

%% Compute the AF
fprintf('Determine ambiguity function..\n')
% Specify the Doppler frequency mis-match range
dopplerRange = 10000; % From +- this Doppler value
dopplerRes = 1200/4;
fd = linspace(-dopplerRange,dopplerRange,dopplerRes); % Set Doppler matrix
fs =  fs_MHz*1e6;

% Determine the length of the siganl
N = length(Signal);
% Allocate memory for the ambiguity function
AFmatrix = zeros(length(fd),N);
T = (length(Signal)-1)/fs; % Determine time length of signal
t = -T/2:1/fs:T/2; % Create time vector
timeindicate = 0;
clear1 = '';

% Ambiguity function
for i=1:length(fd)
    % Console update
    if ((i/length(fd))*100)>timeindicate
        msg = sprintf('%2.2f%% completed.',(i/length(fd))*100);
        msglength = length(msg);
        disp([clear1 msg])
        timeindicate = timeindicate+0.1;
        clear1 = (repmat(sprintf('\b'), 1, msglength+1));
    end
    DopplerShift = Signal_surv.*exp(1j*2*pi*fd(i)*t);   
    AFmatrix(i,:) = abs(fftshift(ifft(fft(DopplerShift).*conj(fft(Signal_ref)))));
end

ms = 1; % time length in milli-seconds of signal
AFmatrix_subset = AFmatrix;

%% Plot the resultant AF
fprintf('Plotting ambiguity function\n')
% AFmatrix = AFmatrix(:,1:10:end); % Decimate columns
% Plot result
figure()
dopplerTicks = -dopplerRange:2*dopplerRange/(dopplerRes-1):dopplerRange; 
rangeTicks = 0:ms/(length(AFmatrix_subset(1,:))-1):ms;

if normalise == 1
    surf(rangeTicks,dopplerTicks,20*log10(abs(AFmatrix_subset./max(max(AFmatrix_subset)))), 'EdgeAlpha', 0)
    axis([0 ms -dopplerRange dopplerRange -100 0])

else
    surf(rangeTicks,dopplerTicks,20*log10(abs(AFmatrix_subset)), 'EdgeAlpha', 0)
    axis([0 ms -dopplerRange dopplerRange min(min(20*log10(abs(AFmatrix_subset)))) max(max(20*log10(abs(AFmatrix_subset))))])
end
% mesh(20*log10(abs(AFmatrix_subset./max(max(AFmatrix_subset))))) % Plot positive half
% mesh(20*log10(abs(AFmatrix./max(max(AFmatrix))))) % Plot whole spectrum
colorbar
colormap hsv

ylabel('Doppler [Hz]')
xlabel('Time [ms]')
zlabel('Power [dB]')


















