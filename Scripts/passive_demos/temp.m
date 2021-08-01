
hinfo = hdf5info('emission.h5');
count = round(size(hinfo.GroupHierarchy.Datasets,2)/2);
numelements = hinfo.GroupHierarchy.Datasets(1).Dims;

I = zeros(numelements*count,1);
Q = zeros(numelements*count,1);

scale = hinfo.GroupHierarchy.Datasets(1).Attributes(3).Value;

for k = 1:count
   Itemp = hdf5read(hinfo.GroupHierarchy.Datasets(2*k-1));
   Qtemp = hdf5read(hinfo.GroupHierarchy.Datasets(2*k));

   I(1+(k-1)*numelements:k*numelements,1) = Itemp;
   Q(1+(k-1)*numelements:k*numelements,1) = Qtemp;

   cmpx_data = I + 1i*Q;
end

cmpx_data = cmpx_data.';
   
data = cmpx_data;
for i = 1:10

   data = [data cmpx_data];
   
end


%file name
file_name = 'new' + .h5';

I = real(data);
Q = imag(data);

h5create(file_name,'/I/value',length(I));
h5create(file_name,'/Q/value',length(Q));

p = path();
path(p);

%writing hdf5 dataset
h5write(file_name,'/I/value',I);
h5write(file_name,'/Q/value',Q);


    