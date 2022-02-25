% Load an HDF5 file produced by FERS (for newer matlab versions)
function [cmplx] = loadfersHDF5_iq(name)

   I = h5read(name, '/I/value');
   Q = h5read(name, '/Q/value');
 
   cmplx = I+ 1i*Q;
   
   %converting to row
   cmplx = cmplx.';
end