function configured_dab_visualization_plot(dab_mode)
    % ---------------------------------------------------------------------    
    % LOAD_DAB_CONSTANTS: Return the paramters for a DAB mode
    %                           (currently for Mode 1 only)
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > dab_mode - array of DAB constants
    %
    %  Outputs
    %  > Figure: Plot dab "domains"
    %
    % ---------------------------------------------------------------------
    
    %plotting from longest to shortest
    y = cat(2, zeros(1,dab_mode.Tnull), ones(1,dab_mode.Ts));
    plot(y,'red','LineWidth',2.5);
    hold on
    plot(y(1:dab_mode.Tg+dab_mode.Tnull),'blue','LineWidth',2.5)
    hold on
    plot(y(1:dab_mode.Tnull),'black','LineWidth',2.5)
    
    %Infomation about plot
    title('Plot visually showing a DAB frames Null Period,Guard Interval and Useful Period ')
    xlabel('Time Index T*n') 
    ylabel('Arbitrary Unit') 

end