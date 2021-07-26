function X = ambiguity_function_V4_1(S,T, fc, pulse_length, pad_multiplier, doppler_bound)


    % ---------------------------------------------------------------------    
    % ambiguity_function_slow: calculates AF using for loop correlations
    %                              with axes VT and tau/T
    %                    
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs 
    %   > S              - The signal which to compute the AF for
    %   > T              - Sample time
    %   > fc             - The center frequency of signal
    %   > pulse length   - Signal duration as an array length (scalar)
    %   > pad_multiplier - Additional zeroes to be appended for doppler
    %                           processing
    %   > doppler_bound  - Number of doppler shifts computed during
    %                           processing
    %  Outputs
    %   > plotted Ambiguity Function
    %
    % ---------------------------------------------------------------------
  
  %appending zeros for addional frequency resolution
  original_length = length(S);
  S = [S zeros(1,pad_multiplier*length(S))];
  
  %creating delay bounds
  %tau delays in increments of T
  delay_upper_bound = length(S);
  delay_lower_bound = 0;
  delay_samples = (delay_upper_bound-delay_lower_bound);
  delay_axis = linspace(delay_lower_bound, delay_upper_bound, delay_samples);
  

   %resolution to be used later
   f_res = (1/(T))/(length(S));
  
  doppler_upper_bound = doppler_bound;
  doppler_lower_bound = -doppler_upper_bound;  
  doppler_axis = linspace(doppler_lower_bound, doppler_upper_bound,2*doppler_upper_bound+1);

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
      X(f,:) = circshift( ifft(x_conj.*x_dop), length(x)/2  );
      
  end
  
  %taking magnitude and normalizing
  X = abs(X);
  X = normalize_matrix(X);
  X = 10*log10(X);
    
  %shifting delay axis to center around zero
  %removing zero padding as well
  delay_axis = delay_axis - pulse_length - original_length*pad_multiplier/2;
  %cutting negative delay
  delay_axis = delay_axis(length(delay_axis)/2:end-original_length*pad_multiplier/2);
  %rescaling axes to standard AF axes
  delay_axis = delay_axis/pulse_length;
  
  %removing negative delay from AF
   X = X(:,length(X)/2:end-original_length*pad_multiplier/2);
  
  % rescaling doppler axis from discrete shifts to VT
  doppler_axis = (pulse_length*T)*doppler_axis*(f_res*3e8/(2*fc));
  
  %plotting
  n = size(delay_axis);
  m = size(doppler_axis);
  o = size(X)
  AF = surf((delay_axis),doppler_axis,X);
  AF.EdgeColor = 'none';
  grid off
  
  %Labeling figure
  xlabel('{ \tau }/{T}  ') 
  ylabel('VT')
  
end