function A_cube = convert_phase_cube_dpsk(A_cube)
    % ---------------------------------------------------------------------    
    % convert_phase_cube_qdpsk: Takes a phase cube and alters it to form a 
    %                           differential phase cube where original
    %                           phases are encoded in the difference
    %                           between previous and current symbol. z =
    %                           z(n-1)*y
    % ---------------------------------------------------------------------
    % Usage:
    %  Inputs
    %  > A_cube - A standard phase cube in the form ((LxN)xF)
    %            
    %  Outputs
    %  > A_cube - A converted dpsk cube
    %
    % ---------------------------------------------------------------------
   
    %running through all rows wihtout altering prs
    for i = 2:size(A_cube,1)
    
        %applying dpsk z(i) = z(i-1)*y(i)
        A_cube(i,:,:) = A_cube(i,:,:).*A_cube(i-1,:,:); 
        
    end
end