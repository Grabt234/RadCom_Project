function X = ambiguity_function_V4(S,T,osf, tot_time, prf)


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
  
  %creating delay bounds
  %tau delays in increments of T
  delay_upper_bound = length(S);
  delay_lower_bound = 0;
  delay_samples = (delay_upper_bound-delay_lower_bound);
  delay_axis = linspace(delay_lower_bound, delay_upper_bound, delay_samples);
  
  %doppler bounds in terms of 
  %max dop frequency
%   f_dop_max = 1000000;
%   %convert to discrete shift
   f_res = (1/(osf*T))/(length(S))
%   %number of shifts 
%   f_dop_shift = floor((f_dop_max/f_res))
  
  doppler_upper_bound = 50;
  doppler_lower_bound = 1;  
  doppler_axis = linspace(doppler_lower_bound, doppler_upper_bound,doppler_upper_bound);

  % x-axis, rows   - delay
  % y-axis, colums - doppler
  X = zeros(length(doppler_axis),length(S));
  
  %precalculating fft's
  x = fft(S);
  x_conj = conj(x);

  %calculating autocorrelation for different doppler cuts
  for f = 1:numel(doppler_axis)
       
      doppler_axis(f);
      
      x_dop = circshift(x,(doppler_axis(f)-1));
      X(f,:) = circshift( ifft(x_conj.*x_dop), length(x)/2   );
      
  end
  
  
  %taking magnitude and normalizing
  X = abs(X);
  X = normalize_matrix(X);
  X = 10*log10(X);

  %rescaling axes to standard AF axes
  delay_axis = delay_axis/length(S);
  doppler_axis = doppler_axis*f_res;
  
  %plotting
  figure;
  n = size(delay_axis);
  m = size(doppler_axis);
  o = size(X);
  AF = surf((delay_axis),doppler_axis,X);
  AF.EdgeColor = 'none';
  grid off
  
  %Labeling figure
  xlabel('Delay: { \tau }/_{ T_{PRT}}  ') 
  ylabel('f_{doppler}')
  
end