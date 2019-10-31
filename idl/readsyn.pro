;
;
;*********************************************************************
   PRO READSYN,FILENAME,ZOBS,RES,NLAM,LAM,NLOOK,LOOK,TANALT,SPECT
;*********************************************************************
;  Purpose:
;     This routine reads the synthetic spectra output file.
;
;  Arguments:
;     (in)  filename = file to be read.
;     (out) zobs     = observer altitude (km).
;     (out) res      = spectra resolution (A).
;     (out) nlam     = number of wavelengths.
;     (out) lam      = wavelength grid (A)
;     (out) nlook    = number of zenith angles.
;     (out) look     = zenith angles (deg).
;     (out) tanalt   = tangent altitudes (km).
;     (out) spect    = spectra (R/A) = f(wavelength,look)
;/////////////////////////////////////////////////////////////////////
;
   READSTD,FILENAME,NLAM,LAM,NLOOK,LOOKLAB,SPECT,NINFO,INFO
;
   INDX = STRPOS(INFO(0),'=')
   ZOBS = FLOAT(STRMID(INFO(0),INDX+1,STRLEN(INFO(0))))
   INDX = STRPOS(INFO(1),'=')
   RES  = FLOAT(STRMID(INFO(1),INDX+1,STRLEN(INFO(1))))
;
   LOOK = FLTARR(NLOOK)
   FOR I = 0,NLOOK-1 DO BEGIN
     INDX    = STRPOS(LOOKLAB(I),'=')
     LOOK(I) = FLOAT(STRMID(LOOKLAB(I),INDX+1,STRLEN(LOOKLAB(I))))
   ENDFOR
;
   TANALT = (6375.0+ZOBS)*SIN(!DTOR*LOOK)-6375.0
;
   RETURN
   END
