
function create_hdf5(name, data)

    %file name
    file_name = name + ".h5"

    I = real(data);
    Q = imag(data);

    h5create(file_name,'/I/value',length(I));
    h5create(file_name,'/Q/value',length(Q));

    %writing hdf5 dataset
    h5write(file_name,'/I/value',I);
    h5write(file_name,'/Q/value',Q);
   
end