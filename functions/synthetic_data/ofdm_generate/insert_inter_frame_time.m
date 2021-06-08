function S = insert_inter_frame_time(S,F,time)
    % ---------------------------------------------------------------------    
    % insert_inter_frame_time: appends interframe time to the begining of 
    %                            of each array row
    %                                  
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > S  - Matrix of frame evelopes
    %   > 
    %  Outputs
    %   > S  - Array of frames with interframe times prepended
    %
    % ---------------------------------------------------------------------
    
    z = zeros(F, length(time));
    
    S = [z S]; 

end