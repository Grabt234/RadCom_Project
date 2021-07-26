function X = ambiguity_function_V5(S,T,osf, tot_time, prf, prf_multiple, prt_bound)


    % ---------------------------------------------------------------------    
    % ambiguity_function_slow: calculates AF using for loop correlations
    %                    
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > S         - The signal which to compute the AF for
    %   > T         - Sample time
    %   > osf       - oversampling factor
    %   > tot_time  - total signal duration
    %   > PRf       - Pulse Repetition frequency
    %  Outputs
    %   > plotted Ambiguity Function
    %
    % ---------------------------------------------------------------------
  
    prf = prf*prf_multiple;
    
  %creating delay bounds
  %tau delays in increments of T
  delay_upper_bound = length(S);
  delay_lower_bound = 0;
  delay_samples = (delay_upper_bound-delay_lower_bound);
  delay_axis = linspace(delay_lower_bound, delay_upper_bound, delay_samples);
  
  %doppler bounds in terms of 
  %max dop frequency
  f_dop_max = 10000*(prf*2*(1/T))/(3*10^8)
  %convert to discrete shift
  f_res = (1/(osf*T))/(length(S))
  %number of shifts 
  f_dop_shift = floor((f_dop_max/f_res))
  
  doppler_upper_bound = f_dop_shift;
  doppler_lower_bound = 1;  
  doppler_axis = linspace(doppler_lower_bound, doppler_upper_bound, doppler_upper_bound);

  % x-axis, rows   - delay
  % y-axis, colums - doppler
  X = zeros(length(doppler_axis),length(S));
  
  %precalculating fft's
  x = fft(S);
  x_conj = conj(x);

  %calculating autocorrelation for different doppler cuts
  for f = 1:numel(doppler_axis)
       
      %delay cut for a given doppler shift
      x_dop = circshift(x,(doppler_axis(f)-1));
      X(f,:) = circshift( ifft(x_conj.*x_dop), length(x)/2   );
      
  end
  
  
  %taking magnitude and normalizing
  X = abs(X);
  X = normalize_matrix(X);
  X = 10*log10(X);

  %rescaling axes to standard AF axes
  delay_axis = delay_axis/length(S);
  doppler_axis = ( doppler_axis*(1/(4*T*length(S)))*3*10^8/(2*(1/T))  ) /prf;
  
  %plotting
  figure;
  n = size(delay_axis)
  m = size(doppler_axis);
  o = size(X)
  
  lower_bound = floor(length(delay_axis)*(0.5-prt_bound));
  upper_bound = floor(length(delay_axis)*(0.5+prt_bound));
  delay_axis = delay_axis(lower_bound:upper_bound);
  delay_axis = delay_axis-0.5;
  
  
  size(delay_axis)
  X = X(:,lower_bound:upper_bound);
  
  AF = surf(  delay_axis  ,doppler_axis,X);
  AF.EdgeColor = 'none';
  grid off
  
  %Labeling figure
  xlabel('Delay: { \tau }/_{ T_{PRT}}  ') 
  ylabel('Doppler: { v }/{ PRF }')
  
end