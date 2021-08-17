



hdf5_file_name_emission = "cw_emission.h5"
hdf5_file_name_ref = "cw_response_surv.h5"
hdf5_file_name_response = "can.h5"

%reading data from hdf5
RefData = loadfersHDF5_cmplx(hdf5_file_name_ref);
cmplx_data_emission = loadfersHDF5_iq(hdf5_file_name_emission);
cmplx_data_response = loadfersHDF5_iq(hdf5_file_name_response);

dab_mode = load_dab_rad_constants(5);

%plot(1:1:length(cmplx_data_emission), cmplx_data_emission)

a = cmplx_data_emission(1,1+dab_mode.Tg:dab_mode.Ts);
length(a)
a = fftshift(fft(a))./length(a);

plot(1:1:length(a),abs(a))