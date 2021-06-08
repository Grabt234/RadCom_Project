function ambiguity_function_very_slow_V0(S,T, delay, doppler, osf)
    % --------------------------------------------------------------------- 
    %                               DEPRECATED   
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
  delay_upper_bound = (length(S)+2*delay)-1;
  delay_lower_bound = -(length(S)+2*delay);
  delay_samples = (delay_upper_bound-delay_lower_bound);
  delay_axis = linspace(delay_lower_bound, delay_upper_bound, delay_samples);

  %doppler bounds
  doppler_upper_bound = doppler;
  doppler_lower_bound = -doppler;
  doppler_samples = (doppler_upper_bound-doppler_lower_bound+1)*osf;
  doppler_axis = linspace(doppler_lower_bound, doppler_upper_bound,doppler_samples);

  % x-axis, rows   - delay
  % y-axis, colums - doppler
  X = zeros(doppler_samples,delay_samples);

  %length of doppler modulator  
  signal_space = linspace(1,length(S), length(S));
  
  for f = 1:numel(doppler_axis)
        doppler_axis(f)
      dop = exp(2*pi*1i*doppler_axis(f)*(T*signal_space));

      X(f,:) = conv(S,S.*dop);


  end

  %taking magnitude and normalizing
  X = abs(X);
  X = normalize_matrix(X);

  figure;
  surf(delay_axis,doppler_axis,X)

end