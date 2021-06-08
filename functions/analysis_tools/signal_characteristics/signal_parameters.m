function signal_parameters(N,L, T,a,b,d,e, F_intra)
    % ---------------------------------------------------------------------    
    % pmepr: calculates the peak to mean envelope power ratio
    %                                             
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > n - Number of subcarriers
    %  > T - number of symbols (per pulse)
    %  > T - Elementary period
    %  > a - Number elementary periods in symbol period
    %  > b - Number elementary periods in integration period
    %  > d - Number elementary periods in intraframe period
    %  > e - Number elementary periods in interframe period
    %  > F_intra - Number of pulses within a single frame
    %
    %  Outputs 
    %  > Null    
    %
    % ---------------------------------------------------------------------
    
    carriers = N
    
    symbols = L
    
    symbol_period = T*a
    
    integration_period = T*b
    
    gaurd_interval = T*(a-b)
    
    rad_frequency_spacing = 1/symbol_period
    
    dab_frequency_spacing = 1/integration_period
    
  
    
    
    
    
    
    
    
    
end