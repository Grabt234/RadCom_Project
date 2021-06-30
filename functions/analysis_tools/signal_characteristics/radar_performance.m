function radar_performance(mode, T)
    % ---------------------------------------------------------------------    
    % radar_performance: 
    %                                             
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > mode:  the dab mode to calculate radar performance for
    %  >    T:  elementary print statements
    %
    %  Outputs 
    %  > print statements   
    %
    % ---------------------------------------------------------------------
    
    dab_mode = load_dab_rad_constants(mode);
    
    elementary_period = T
    
    carriers = dab_mode.K
    
    symbols = dab_mode.L
    
    symbol_period = dab_mode.Ts*T
    
    integration_period = dab_mode.Tu*T
    
    gaurd_interval = dab_mode.Tg*T
    
    rad_frequency_spacing = 1/(symbol_period)
    
    dab_frequency_spacing = 1/(integration_period)
    
  
    
    
    
    
    
    
    
    
end