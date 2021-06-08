function ambiguity_function_slow_V1(S,T, delay, doppler, osf)


    % ---------------------------------------------------------------------    
    % ambiguity_function_slow: calculates AF using for loop correlations
    %                    
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > S - the signal which to compute the AF for
    %  Outputs
    %   > X
    %   > Y
    %   > Z - degree of match in AF
    %
    % ---------------------------------------------------------------------
  
  
  %creating delay bounds
  delay_upper_bound = length(S);
  delay_lower_bound = 0;
  delay_samples = (delay_upper_bound-delay_lower_bound);
  delay_axis = linspace(delay_lower_bound, delay_upper_bound, delay_samples);
  
  %adding in arbitrary frequency resolution
  original_length = length(S);
  pad = zeros(1, 800);
  S = [S pad];
  
  %doppler bounds
  doppler_upper_bound = doppler;
  doppler_lower_bound = -doppler;
  doppler_samples = (doppler_upper_bound-doppler_lower_bound+1)*osf;
  doppler_axis = linspace(doppler_lower_bound, doppler_upper_bound,doppler_samples);

  % x-axis, rows   - delay
  % y-axis, colums - doppler
  X = zeros(doppler_samples,length(S));
  
  %precalculating fft's
  x = fft(S);
  x_conj = conj(x);

  %calculating autocorrelation for different doppler cuts
  for f_dop = 1:numel(doppler_axis)
    
      doppler_axis(f_dop)
      x_dop = circshift(x,doppler_axis(f_dop));
      X(f_dop,:) = ifft(x_conj.*x_dop);
      
  end
  
  %cut zeros
  X = X(1:end,1:original_length);
  
  %taking magnitude and normalizing
  X = abs(X);
  X = normalize_matrix(X);

  %plotting
  figure;
  surf(delay_axis,doppler_axis,X)
  
  %Labeling figure
  xlabel('Delay') 
  ylabel('Doppler') 
end