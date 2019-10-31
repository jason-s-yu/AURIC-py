;
;
;*******************************************************************
   PRO READEUV,FILENAME,NLAM,LAM,EUV
;*******************************************************************
;  Purpose:
;     This routine reads the solar EUV spectrum file.
;
;  Arguments:
;     (in)  filename = file to be read.
;     (out) nlam     = number of wavelengths.
;     (out) lam      = wavelength (Angstrom).
;     (out) euv      = solar EUV flux (photons cm^-2 sec^-1)
;///////////////////////////////////////////////////////////////////
;
   READSTD,FILENAME,NLAM,LAM,NLAB,LAB,EUV
;
   RETURN
   END
