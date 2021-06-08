function S = insert_intra_frame_time(S,F,length)
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
    
    z = zeros(F, length);
    
    S = [z S]; 

end