%pulse cancellation

hdf5_file_name_ref = "cw_response_surv.h5"
hdf5_file_name_response = "cw_response.h5"

RefData = loadfersHDF5_cmplx(hdf5_file_name_ref);
cmplx_data_response = loadfersHDF5_cmplx(hdf5_file_name_response);

proc.cancellationMaxRange_m = 10000;
proc.cancellationMaxDoppler_Hz = 0;
proc.TxToRefRxDistance_m = 1;
proc.nSegments = 16;
proc.nIterations = 20;
proc.Fs = 2.048e7;
proc.alpha = 0;
proc.initialAlpha = 0;

data = CGLS_Cancellation_RefSurv_2(RefData.', cmplx_data_response.', proc);

%file name
file_name = 'can.h5';

I = real(data);
Q = imag(data);

h5create(file_name,'/I/value',length(I));
h5create(file_name,'/Q/value',length(Q));

p = path();
path(p);

%writing hdf5 dataset
h5write(file_name,'/I/value',I);
h5write(file_name,'/Q/value',Q);
