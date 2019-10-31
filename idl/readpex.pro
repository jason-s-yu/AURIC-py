;
;
;*********************************************************************
   PRO READPEX,FILENAME,NEGRID,EGRID,NALT,ALT,PEX
;*********************************************************************
;  Purpose:
;     This routine reads the photoelectron data (either source
;     function or flux).
;
;  Arguments:
;     (in)  filename = file to be read.
;     (out) negrid   = number of energies.
;     (out) egrid    = energy grid.
;     (out) nalt     = number of altitudes.
;     (out) alt      = altitude grid.
;     (out) pex      = either photoelectron source function or
;                      photoelectron flux,depends on the input file.
;                      The first dimension corresponds to energy while
;                      the second corresponds to altitude.
;/////////////////////////////////////////////////////////////////////
;
   READSTD,FILENAME,NEGRID,EGRID,NALT,ALTLAB,PEX
;
   ALT = FLTARR(NALT)
;
   FOR I = 0,NALT-1 DO BEGIN
     INDX   = STRPOS(ALTLAB(I),'=')
     ALT(I) = FLOAT(STRMID(ALTLAB(I),INDX+1,STRLEN(ALTLAB(I))))
   ENDFOR
;
   RETURN
   END
