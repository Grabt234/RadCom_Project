function ambiguity_function_very_slow_V1(S,T, delay, doppler, osf)
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
  
  
  %creating positive delay bounds
  delay_upper_bound = (length(S)+2*delay)-1;
  delay_lower_bound = 0;
  delay_samples = (delay_upper_bound-delay_lower_bound);
  delay_axis = linspace(delay_lower_bound, delay_upper_bound, delay_samples);

  %creating doppler bounds
  doppler_upper_bound = doppler;
  doppler_lower_bound = -doppler;
  doppler_samples = (doppler_upper_bound-doppler_lower_bound);
  doppler_axis = linspace(doppler_lower_bound, doppler_upper_bound,doppler_samples);

  % x-axis, rows   - delay
  % y-axis, colums - doppler
  X = zeros(doppler_samples,delay_samples);

  %length of doppler modulator  
  signal_space = linspace(1,length(S), length(S));
  
  for f = 1:numel(doppler_axis)
       
       doppler_axis(f)
       %creating doppler multiplier
       dop = exp(2*pi*1i*f*(T*signal_space));
       
       plot(dop);
       hold on
       
       %A complete symetrical convolution
       whole = (conv(S.*dop,S));
       
       %using symmetry and taking half of array
       half = whole(1:(length(whole)-1)/2);
       
       %adjusting bounds so halfway becomes origin
       half = flip(half);
       
       %storing doppler case
       X(f,:) = half;


  end

  %taking magnitude and normalizing
  X = abs(X);
  X = normalize_matrix(X);
   
  %Plotting
  figure; 
  AF = surf(delay_axis,doppler_axis,X);
  AF.EdgeColor = 'none';
  grid off

  
  %Labeling figure
  xlabel('Delay') 
  ylabel('Doppler') 

end