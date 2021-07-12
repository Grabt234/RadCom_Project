function map = define_alphabet_map(n)
    % ---------------------------------------------------------------------    
    % define_alphabet: creates disctionary between bytes and phases
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
            keySet = {'0','1'};
            valueSet = [0 1*pi];
            map = containers.Map(keySet,valueSet);
            
        case n == 2
            
            %alphabet size 2^2
            keySet = {'00','01','10','11'};
            valueSet = [0*pi 0.5*pi 1*pi 1.5*pi];
            map = containers.Map(keySet,valueSet);
            
            
        case n == 3
            
            %alphabet size 2^3
            keySet = {'000','001','010','011','100','101','110','111'};
            valueSet = [0 0.25*pi 0.5*pi 0.75*pi 1*pi 1.25*pi 1.5*pi 1.75*pi];
            map = containers.Map(keySet,valueSet);
            
            
        otherwise 
            disp('Select n element of [1,2,3],returned n=2')
            
            
            keySet = {'00','01','10','11'};
            valueSet = [0 0.5*pi 1*pi 1.5*pi];
            map = containers.Map(keySet,valueSet);
    end   

end