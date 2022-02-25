function H = build_matched_filter(h)
    % ---------------------------------------------------------------------    
    % build_matched_filter: creates matched filter using a given reference
    %                               signal
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > h:        The reference signal
    %
    %  Outputs
    %   > H:        matched filter coefficients
    %
    % ---------------------------------------------------------------------
    
    H = conj( h (end:-1:1) );
    
end