function map = define_inverse_alphabet_map(n)
    % ---------------------------------------------------------------------    
    % define_inverse_alphabet_map: creates disctionary between bytes and phases
    %                   where n element of [1,2,3]
    %                                  
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %   > n    - 2^n letters in the alphabet
    %   
    %  Outputs
    %   > map  - map of the "phase alphabet for binary encoding" 
    %
    % ---------------------------------------------------------------------
 
    switch true
    
        case n == 1
            
            %alphabet size 2^1
            
            valueSet = {'0','1'};
            keySet = [1 -1];
            map = containers.Map(keySet,valueSet);
            
        case n == 2
            
            %alphabet size 2^2
            valueSet = {'00','01','10','11'};
            keySet = [0 90  180 270];
            map = containers.Map(keySet,valueSet);
                      
        otherwise 
            disp('Select n element of [1,2,3],returned n=2')
            
    end   

end