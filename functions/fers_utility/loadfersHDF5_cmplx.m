% Load an HDF5 file produced by FERS
function [cmpx_data] = loadfersHDF5_cmplx(name)
   hinfo = hdf5info(name);
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
end