function prs = build_prs_custom(dab_mode)
    % ---------------------------------------------------------------------    
    % build_prs_custom: takes the standard DAB prs and isolates nearest L/2
    %               pulses in order to create custom prs
    %                           
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > L - number of prs symbols required for sub carriers
    %
    %  Outputs
    %  > prs - the new prs for L carriers
    %
    % ---------------------------------------------------------------------
   transmission_mode =1;
   
   if (transmission_mode == 1)
        % LUTs for Mode 1:
        k_table = [[-768, -737, 0, 1]
                   [-736, -705, 1, 2]
                   [-704, -673, 2, 0]
                   [-672, -641, 3, 1]
                   [-640, -609, 0, 3]
                   [-608, -577, 1, 2]
                   [-576, -545, 2, 2]
                   [-544, -513, 3, 3]
                   [-512, -481, 0, 2]
                   [-480, -449, 1, 1]
                   [-448, -417, 2, 2]
                   [-416, -385, 3, 3]
                   [-384, -353, 0, 1]
                   [-352, -321, 1, 2]
                   [-320, -289, 2, 3]
                   [-288, -257, 3, 3]
                   [-256, -225, 0, 2]
                   [-224, -193, 1, 2]
                   [-192, -161, 2, 2]
                   [-160, -129, 3, 1]
                   [-128,  -97, 0, 1]
                   [-96,   -65, 1, 3]
                   [-64,   -33, 2, 1]
                   [-32,    -1, 3, 2]
                   [  1,    32, 0, 3]
                   [ 33,    64, 3, 1]
                   [ 65,    96, 2, 1]
                   [ 97,   128, 1, 1]
                   [ 129,  160, 0, 2]
                   [ 161,  192, 3, 2]
                   [ 193,  224, 2, 1]
                   [ 225,  256, 1, 0]
                   [ 257,  288, 0, 2]
                   [ 289,  320, 3, 2]
                   [ 321,  352, 2, 3]
                   [ 353,  384, 1, 3]
                   [ 385,  416, 0, 0]
                   [ 417,  448, 3, 2]
                   [ 449,  480, 2, 1]
                   [ 481,  512, 1, 3]
                   [ 513,  544, 0, 3]
                   [ 545,  576, 3, 3]
                   [ 577,  608, 2, 3]
                   [ 609,  640, 1, 0]
                   [ 641,  672, 0, 3]
                   [ 673,  704, 3, 0]
                   [ 705,  736, 2, 1]
                   [ 737,  768, 1, 1]];

        k_time_frequency_phase_table = ...
            [[0, 2, 0, 0, 0, 0, 1, 1, 2, 0, 0, 0, 2, 2, 1, 1, 0, 2, 0, 0, 0, 0, 1, 1, 2, 0, 0, 0, 2, 2, 1, 1 ]
            [0, 3, 2, 3, 0, 1, 3, 0, 2, 1, 2, 3, 2, 3, 3, 0, 0, 3, 2, 3, 0, 1, 3, 0, 2, 1, 2, 3, 2, 3, 3, 0 ]
            [0, 0, 0, 2, 0, 2, 1, 3, 2, 2, 0, 2, 2, 0, 1, 3, 0, 0, 0, 2, 0, 2, 1, 3, 2, 2, 0, 2, 2, 0, 1, 3 ]
            [0, 1, 2, 1, 0, 3, 3, 2, 2, 3, 2, 1, 2, 1, 3, 2, 0, 1, 2, 1, 0, 3, 3, 2, 2, 3, 2, 1, 2, 1, 3, 2 ]];

        % Build phase reference symbol
        prs_mode_1 = zeros(1,2048);
        idx_offset = 1025;

        % Calculated according to PRS generator algorithm
        % For more info, see DAB Standard document
        
        % for row in carrier index table
        for r = k_table.'
            
            % From carrier index min to carrier index max
            for c = r(1):r(2)
                
                % Pi/2 * k_time_frequency_phase_table[i , j]
                % Where j is "local carrier index" k-k'
                phi = pi/2 * (k_time_frequency_phase_table(r(3)+1,c-r(1)+1) + r(4));
                
                % k with respect to center frequency
                % Shift such that carrier index c is positive
                prs_mode_1(c + idx_offset) = exp(1j*phi);
                
            end
        end
    else
        fprintf("Transmission Mode %d is either invalid or has not yet been implemented.\n", ...
            transmission_mode);
   end
    
   
   %extracting L references
   prs = prs_mode_1(1025 - (dab_mode.K)/2:1025 + (dab_mode.K)/2 -1);
   prs = padarray(prs,[0, (dab_mode.Tu - dab_mode.K)/2 ],0,'both');
 
   
end














