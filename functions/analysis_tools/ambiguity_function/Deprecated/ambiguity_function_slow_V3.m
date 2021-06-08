function ambiguity_function_slow_V3(S,T, delay, doppler, osf, Tp, cpi, prf)


    % ---------------------------------------------------------------------    
    % ambiguity_function_slow: calculates AF using for loop correlations
    %                    
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > S   - The signal which to compute the AF for
    %   > T   - Sample time
    %   > Tp  - pulse length
    %   > PRT - Pulse Repetition Time
    %  Outputs
    %   > plotted Ambiguity Function
    %
    % ---------------------------------------------------------------------
  
  
  %creating delay bounds
  %tau delays in increments of T
  delay_upper_bound = length(S);
  delay_lower_bound = 0;
  delay_samples = (delay_upper_bound-delay_lower_bound);
  delay_axis = linspace(delay_lower_bound, delay_upper_bound, delay_samples);
  
  %adding in arbitrary frequency resolution
  original_length = length(S);
  
  %doppler bounds
  doppler_upper_bound = doppler;
  doppler_lower_bound = -doppler;
  doppler_samples = (doppler_upper_bound-doppler_lower_bound+1);
  doppler_axis = linspace(doppler_lower_bound, doppler_upper_bound,doppler_samples);

  % x-axis, rows   - delay
  % y-axis, colums - doppler
  X = zeros(doppler_samples,length(S));
  
  %precalculating fft's
  x = fft(S);
  x_conj = conj(x);

  %calculating autocorrelation for different doppler cuts
  for f_dop = 1:numel(doppler_axis)
    
      f_shift = f_dop - 1;
      x_dop = circshift(x,f_shift);
      X(f_dop,:) = ifft(x_conj.*x_dop);
      
  end
  
  %cut zeros
  X = X(1:end,1:original_length);
  
  %taking magnitude and normalizing
  X = abs(X);
  X = normalize_matrix(X);
  %X = log(X);

  
  %plotting
  figure;
  
  delay_axis = delay_axis*T/prt;
  doppler_axis = ( doppler_axis*(1/(T*length(S)))*3*10^8/(2*(1/T))  ) /prf;
  
  AF = surf((delay_axis),doppler_axis,X);
  AF.EdgeColor = 'none';
  grid off
  
  %Labeling figure
  xlabel('Delay: { \tau }/_{ T_{PRT}}  ') 
  ylabel('Doppler: { v }/{ PRF }') 
end